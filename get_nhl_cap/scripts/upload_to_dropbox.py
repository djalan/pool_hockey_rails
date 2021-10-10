import dropbox

TOKEN = "hnrxdt3nsOoAAAAAAAAAAfCnVS9OBaRMSNMROKSh_OC8VgvLX1I8i3grGQ0DEoUp"

REMOTE = "/Pool Ally/draft.html"
LOCAL = "/Users/alainsirois/workspace/2020_2021_capfriendly/draft.html"

client = dropbox.Dropbox(TOKEN)
print('[SUCCESS] dropbox account linked')

client.files_upload(
    open(LOCAL, 'rb').read(),
    REMOTE,
    mode=dropbox.files.WriteMode.overwrite
)
print('[SUCCESS] uploaded!')

