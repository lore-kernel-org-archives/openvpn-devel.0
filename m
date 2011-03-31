Message-ID: <4D943B5E.50106@...1114...>
Date: Thu, 31 Mar 2011 10:29:18 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1301487818-4450-1-git-send-email-davids@...1347...>
	<4D9433D0.9090508@...1147...>
In-Reply-To: <4D9433D0.9090508@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Fix the
	--client-cert-not-required	feature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 31/03/11 09:57, Jan Just Keijser wrote:
> Hi David,
>
> David Sommerseth wrote:
>> Commit 2e8337de248ef0b5b48cbb2964da0d5c3f28b15b introduced a new
>> feature for using other SSL certificate fields for authentication
>> than then CN field.
>>
>> This commit introduced a bug, which made the verify_callback()
>> function getting called even if --client-cert-not-required was
>> enabled in the config.
>>
>> The reason for this was that an 'else' statement was lacking a
>> couple of curly braces.  The offending commit in reality moved
>> the setup the verify_callback() function out of the 'else'
>> statement.
>>
>> Report-URL: https://community.openvpn.net/openvpn/ticket/108
>> Report-URL: https://forums.openvpn.net/topic7751.html
>> Signed-off-by: David Sommerseth <davids@...1347...>
>> ---
>>  ssl.c |   10 ++++++----
>>  1 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/ssl.c b/ssl.c
>> index ed10714..6d9a9fd 100644
>> --- a/ssl.c
>> +++ b/ssl.c
>> @@ -1874,13 +1874,15 @@ init_ssl (const struct options *options)
>>      }
>>    else
>>  #endif
>> +    {
>>  #ifdef ENABLE_X509ALTUSERNAME
>> -  x509_username_field = (char *) options->x509_username_field;
>> +      x509_username_field = (char *) options->x509_username_field;
>>  #else
>> -  x509_username_field = X509_USERNAME_FIELD_DEFAULT;
>> +      x509_username_field = X509_USERNAME_FIELD_DEFAULT;
>>  #endif
>> -  SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT,
>> -			verify_callback);
>> +      SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT,
>> +                          verify_callback);
>> +    }
>>
>>    /* Connection information callback */
>>    SSL_CTX_set_info_callback (ctx, info_callback);
>>
> weird, but with your patch I get a completely different error:
>
> Thu Mar 31 09:55:01 2011 us=368010 194.171.96.28:44859 Could not create
> temporary file 'openvpn_acf_ab60cdb4d9d6bdf5d3c7812ea9710705.tmp':
> Permission denied
> Thu Mar 31 09:55:01 2011 us=368145 194.171.96.28:44859 Exiting
>
>
> if I run it with '--tmp-dir /tmp' it works again - looks like this patch
> triggers another bug?

Actually, it's not another bug, it's an expected behavioural change.  In
OpenVPN 2.1 and earlier there is a function which is called quite often
when plug-in's or the script hooks are used, which generates a unique
filename and passes this filesname to the plug-in or script.  This function
was called create_temp_filename().  Plug-ins or script could then create
this file if it wanted to pass some information back to OpenVPN.

This might be a security issue, where it is, theoretically at least,
possible to intercept OpenVPN and put configuration statements which would
then be processed by the OpenVPN server.

To solve this the create_temp_filename() function has been replaced by
create_temp_file(), which creates a temp file which is read/writeable only
by the OpenVPN user before the plug-in/script is called.  The
plug-in/script only needs to open this file and write to it to pass
information back.  The OpenVPN server evaluates the file and deletes it
when the plug-in/script is done.

The reality is that when you use --plugin or some of the script hooks, you
now need to have a writeable directory anyway.  Earlier this was only
needed if the plug-in/script did create the file.  So it's not really a
bug, but it reveals this behaviour more easily now.

For those concerned about performance, it is possible to put this --tmp-dir
on a tmpfs or RAM disk mounted directory.  It's also been discussed briefly
if we should default to /tmp, %TMPDIR%, or similar standard paths for
- --tmp-dir.  I think we need to do that.

The man page has been updated to cover this change.  But it could probably
be mentioned as well in the --client-connect and --plugin sections too.

For OpenVPN 2.3, a new plug-in API is comming.  I'm considering to extend
that so that the plug-in can create this file and provide the filename back
to OpenVPN.  This sounds easy, but I have not looked at possible security
considerations here yet.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2UO1wACgkQDC186MBRfrqGOACgmtxxYU2riZxQPJS/GXx9Ah6O
f5UAnjqD1uhwUwFqMOnDv1jGPM43ZMnx
=bEod
-----END PGP SIGNATURE-----

