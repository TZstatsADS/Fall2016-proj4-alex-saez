
# move all song files into unique directory

songs_A = list.files('../data/A/', recursive = T)
songs_B = list.files('../data/B/', recursive = T)

for(s in songs_A){
  oldname = paste('../data/A', s, sep='/')
  newname = paste('../data/songs', strsplit(s,'/')[[1]][3], sep='/')
  file.rename(from=oldname, to=newname)
}

for(s in songs_B){
  oldname = paste('../data/B', s, sep='/')
  newname = paste('../data/songs', strsplit(s,'/')[[1]][3], sep='/')
  file.rename(from=oldname, to=newname)
}
