#!/usr/bin/perl

$main_dir = `pwd`;
chomp($main_dir);

$sub_fnm = $main_dir."/bin/sub_single_local.sh";
$n_trajs = 10000;
$i_job0 = 5429;
for ($i=0;$i<=20000;$i++){
  $n_jobs=`bjobs | wc -l`;
  chomp($n_jobs);
  print "$i\n";
  if($n_jobs < 451){
    $i_job1 = $i_job0+451-$n_jobs-1;
    if($i_job1 > $n_trajs){
      $i_job1 = $n_trajs;
    }
    for($i_job=$i_job0; $i_job<=$i_job1; $i_job++){
      $work_dir = $main_dir."/trajs/$i_job";
      chdir $work_dir;
      print $work_dir."\n";
      $info = `bsub $sub_fnm`;
      print $info;
      if($info !~ 'is submitted to queue <intelG_small>'){
        last;
      }
    }
    if($i_job1 >= $n_trajs){
      exit;
    }
    $i_job0=$i_job;
  }
  sleep(60);
}
