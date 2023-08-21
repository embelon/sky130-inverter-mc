v {xschem version=3.4.1 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 100 0 100 40 {
lab=Vout}
N 40 -30 60 -30 {
lab=Vin}
N 40 -30 40 70 {
lab=Vin}
N 40 70 60 70 {
lab=Vin}
N 100 -80 100 -60 {
lab=VDD}
N 100 100 100 120 {
lab=GND}
N -210 100 -210 120 {
lab=GND}
N -130 100 -130 120 {
lab=GND}
N -130 20 -130 40 {
lab=VDD}
N -210 20 -210 40 {
lab=Vin}
N 20 20 40 20 {
lab=Vin}
N 100 20 160 20 {
lab=Vout}
N 100 70 120 70 {
lab=GND}
N 120 70 120 110 {
lab=GND}
N 100 110 120 110 {
lab=GND}
N 100 -30 120 -30 {
lab=VDD}
N 120 -70 120 -30 {
lab=VDD}
N 100 -70 120 -70 {
lab=VDD}
C {nfet_01v8.sym} 80 70 0 0 {name=M1
L=0.15
W=1
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {pfet_01v8.sym} 80 -30 0 0 {name=M2
L=0.15
W=1
nf=1
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=pfet_01v8
spiceprefix=X
}
C {devices/code_shown.sym} 280 -160 0 0 {name=SPICE 
only_toplevel=false 
value="
.control
  set wr_vecnames
  set wr_singlescale
  let mc_runs=10
  let run=1
  set curplot=new
  set scratch=$curplot
  setplot $scratch
  dowhile run <= mc_runs
    save v(Vin) v(Vout)
    dc Vin 0 1.8 0.01
    wrdata inverter\{$&run\}.txt v(Vout)
    set run ="$&run"
    set dt = $curplot
    setplot $scratch
    let Vout\{$run\}=\{$dt\}.v(Vout)
    setplot $dt
    reset
    let run = run + 1
  end
  setplot $scratch
  plot allv vs dc1.v(Vin)
  set hcopydevtype = svg
  hardcopy out_vs_in.svg allv vs dc1.v(Vin)
.endc
"}
C {devices/gnd.sym} 100 120 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -130 70 0 0 {name=Vdd value=1.8}
C {devices/vsource.sym} -210 70 0 0 {name=Vin value=0.5}
C {devices/gnd.sym} -130 120 0 0 {name=l2 lab=GND}
C {devices/gnd.sym} -210 120 0 0 {name=l3 lab=GND}
C {devices/vdd.sym} 100 -80 0 0 {name=l4 lab=VDD}
C {devices/vdd.sym} -130 20 0 0 {name=l5 lab=VDD}
C {devices/lab_pin.sym} -210 20 1 0 {name=p1 sig_type=std_logic lab=Vin}
C {corner.sym} -230 -170 0 0 {name=CORNER only_toplevel=false corner=tt_mm}
C {devices/lab_pin.sym} 160 20 2 0 {name=p2 sig_type=std_logic lab=Vout}
C {devices/lab_pin.sym} 20 20 0 0 {name=p3 sig_type=std_logic lab=Vin}
