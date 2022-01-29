#!/bin/bash

# backup en grupoweme.com.ar
# asi sube al ftp. si le agrego REVERSE los baja
# lftp -u a3629322,fayu4519 -e "set ftp:list-options -a; mirror --reverse --verbose --log=loggrupoweme.txt /media/EXPRESSGATE/bcktrabajo/Trabajo/Administracion /backup/Administracion" grupoweme.com.ar

# MODO DE USO
#    "--reverse" option means uploading files to a remote FTP server.
#    "--delete" option means removing files not present in the source directory.
#    "--parallel=3" option means uploading upto 3 files in parallel.
#    "--exclude-glob .git" option means excluding matching folders (e.g., .git).
#    "--older-than='now-7days'" option means uploading files which were modified more than seven days ago. 
#	lftp -u username,password  -e "mirror --delete --only-newer --verbose path/to/source_directory path/to/target_directory" ftpsite


# backup en panificadoradelsur.com.ar
lftp -u a2556282,fayu4519 -e "set ftp:list-options -a; mirror --reverse --verbose --log=logpanificadora.txt /media/EXPRESSGATE/bcktrabajo/Trabajo/WEME /backup/WEME" panificadoradelsur.com.ar


