function Write_POSCAR_arb(atomType, Count, symg, numIons, lattice, coor, tempFolder)

### newly added file on 210414
### copied from Write_POSCAR on 210414


if ~exist(tempFolder,'dir')   # added on 210414
[nothing] = unix(['mkdir -p ' tempFolder]);   # added on 210414
end   # added on 210426

if isempty(symg)
symg = 0;
end
lat_6 = latConverter(lattice);  
lat_6(4:6) = lat_6(4:6)*180/pi;

#fp = fopen('POSCAR', 'w');
fp = fopen([tempFolder '/CONTCAR'], 'w');   # added on 210414


fprintf(fp, 'EA%-4d %6.3f %6.3f %6.3f %5.2f %5.2f %5.2f Sym.group: %4d\n', Count, lat_6(1:6), symg);    
fprintf(fp, '1.0000\n');
for latticeLoop = 1 : 3
fprintf(fp, '%12.8f %12.8f %12.8f\n', lattice(latticeLoop,:));    # modified 210630
#fprintf(fp, '%12.6f %12.6f %12.6f\n', lattice(latticeLoop,:));    # modified 210630
end
if sum(atomType)>0
for i=1:length(numIons)
if numIons(i) > 0
fprintf(fp,'%4s', megaDoof(ceil(atomType(i))));
end
end
fprintf(fp, '\n');
end
for i=1:length(numIons)
if numIons(i) > 0
fprintf(fp, '%4d ', numIons(i));
end
end 
fprintf(fp, '\n');
fprintf(fp, 'Direct\n');
for coordLoop = 1 : sum(numIons)
fprintf(fp, '%12.8f %12.8f %12.8f\n', coor(coordLoop,:));    # modified 210630
#fprintf(fp, '%12.6f %12.6f %12.6f\n', coor(coordLoop,:));    # modified 210630
end

fprintf(fp, '     \n');   # added on 210414
fprintf(fp, '0.0000 0.0000 0.0000');   # added on 210414

fclose(fp);
