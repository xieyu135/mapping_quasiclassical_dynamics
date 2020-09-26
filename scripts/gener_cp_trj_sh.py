#!/usr/bin/env python
import os

def get_nuc_sam_exe(nuc_sampling_method):
    '''
    nuc_sampling_method:
    1. action_angle
    2. wigner (temperature)
    3. action angle (temperature)
    4. action angle (window)    
    '''
    if nuc_sampling_method == 1:
        sam_nuc = '$sampling/action_angle/main_action_angle.exe'
        sam_nuc+= ' < main_action_angle_nuc_input'
    elif nuc_sampling_method == 2 or nuc_sampling_method == 3:
        sam_nuc = '$sampling/sampling2_pjw/main_initial_sampling.exe'
        sam_nuc+= ' < main_Tk_nuc_input\n'
        sam_nuc+= 'python $sampling/sampling2_pjw/extra_ini_trj.py'
        sam_nuc+= ' < extra_ini_trj_input'
    elif nuc_sampling_method == 4:
        sam_nuc = '$sampling/SQC/action_angle_uni/main_action_angle_uni.exe'
        sam_nuc+= ' < main_action_angle_nuc_input'
    else :
        print 'Wrong nuc_sampling_method input!'
        raise IOError
    return sam_nuc
def get_elec_sam_exe(elec_sampling_method):
    '''
    elec_sampling_method:
    1. action_angle
    2. action_angle (rectangle)
    3. action_angle (triangle)
    4. action_angle (triangle_xy)
    5. angular momentum
    -1. the others
    '''
    if elec_sampling_method == 1:
        sam_elec = '$sampling/action_angle_uni/main_action_angle_uni.exe'
        sam_elec+= ' < main_action_angle_nuc_input'
    if elec_sampling_method == 2:
        sam_elec = '$sampling/SQC/action_angle_uni/main_action_angle_uni.exe'
        sam_elec+= ' < main_action_angle_nuc_input'
    if elec_sampling_method == 3:
        sam_elec = '$sampling/SQC/action_angle_uni/'
        sam_elec+= 'main_action_angle_uni_triangle_many_state_miller.exe'
        sam_elec+= ' < main_action_angle_nuc_input'
    if elec_sampling_method == 4:
        sam_elec = '$sampling/SQC/action_angle_uni/'
        sam_elec+= 'main_action_angle_uni_triangle_many_state.exe'
        sam_elec+= ' < main_action_angle_nuc_input'
    if elec_sampling_method == 5:
        sam_elec = '$sampling/SQC/angular_triangle/main.exe'
        sam_elec+= ' < angular_elec_input'
    else :
        print 'Wrong elec_sampling_method input!'
        raise IOError
    return sam_elec
def gener_cp_trj_sh(nuc_sampling_method,
                    elec_sampling_method):
    '''
    Used to creat the file 'cp_trj.sh'.  
    '''
    sampling_dir = os.path.join(
      os.path.split(os.path.realpath(__file__))[0],
      '..', 'src', 'sampling')
    sam_nuc = get_nuc_sam_exe(nuc_sampling_method)
    sam_elec = get_elec_sam_exe(elec_sampling_method)
    
    f = open('cp_trj.sh', 'w')
    f.write('sampling=' + sampling_dir + '\n')
    
    f.write('''main_dir=$PWD

exec 7< traj_pop_aver_SQC_input
read -u 7 a 
read -u 7 a 
read -u 7 n_trj a
trj0=1
for((i=$trj0;i<=$n_trj;i++))
do
  mkdir -p trajs/$i
  cp lambda?_coupling.input ene.input k_tun.input freq.input trajs/$i
  cp dyn.input trajs/$i
done

'''
+ sam_elec + '\n' +
'''
for((i=$trj0;i<=$n_trj;i++))
do
  mv traj_${i}.inp trajs/$i/trj_elec.input
done

'''
+ sam_nuc + '\n' +
'''
for((i=$trj0;i<=$n_trj;i++))
do
  mv traj_${i}.inp trajs/$i/trj.input
done
'''
)
    f.close()


def run():
    gener_cp_trj_sh(nuc_sampling_method,
                    elec_sampling_method)

if __name__=='__main__':
    run()
