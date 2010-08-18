Message-ID: <4C6BF76E.8040703@...1114...>
Date: Wed, 18 Aug 2010 17:08:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4C6BD3CB.5050009@...68...>
	<1282136643-22193-1-git-send-email-dazo@...384...>
	<4C6BDFD1.3030707@...68...>
In-Reply-To: <4C6BDFD1.3030707@...68...>
Subject: Re: [Openvpn-devel] [PATCH v2] Test framework improvment - Do not
 FAIL	if t_client.rc is missing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 18/08/10 15:27, Matthias Andree wrote:
> Am 18.08.2010 15:04, schrieb David Sommerseth:
>> This is to avoid 'make check' fail if this extra test case is not
>> configured.
>>
>> Signed-off-by: David Sommerseth <dazo@...384...>
>> ---
>>  t_client.sh.in |   20 ++++++++++----------
>>  1 files changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/t_client.sh.in b/t_client.sh.in
>> index 664b2fd..d3a4295 100755
>> --- a/t_client.sh.in
>> +++ b/t_client.sh.in
>> @@ -12,6 +12,16 @@
>>  # - for "ping6" checks: fping6 binary in $PATH
>>  #
>>  
>> +if [ -r ./t_client.rc ] ; then
>> +    . ./t_client.rc
>> +elif [ -r "${srcdir}"/t_client.rc ] ; then
>> +    . "${srcdir}"/t_client.rc
>> +else
>> +    echo "$0: cannot find 't_client.rc' in current directory or" >&2
>> +    echo "$0: source dir ('${srcdir}').  SKIPPING TEST." >&2
>> +    exit 77
>> +fi
>> +
> 
> I have occasionally been bitten by such ambiguities between current working
> directory and $srcdir.  I'd propose to steer clear of such precedence rules.

I'll consider a fix here, or maybe Gert got some good ideas as well.
Anyway, I think that should be covered in another patch, where this
issue is tackled separately.

>>  if [ ! -x ./openvpn ]
>>  then
>>      echo "no (executable) openvpn binary in current directory. FAIL." >&2
>> @@ -24,16 +34,6 @@ then
>>      exit 1
>>  fi
>>  
>> -if [ -r ./t_client.rc ] ; then
>> -    . ./t_client.rc
>> -elif [ -r "${srcdir}"/t_client.rc ] ; then
>> -    . "${srcdir}"/t_client.rc
>> -else
>> -    echo "cannot find 't_client.rc' in current directory or" >&2
>> -    echo "source dir ('${srcdir}').  FAIL." >&2
>> -    exit 1
>> -fi
>> -
>>  if [ -z "$CA_CERT" ] ; then
>>      echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
>>      exit 0
> 
> I think you missed this "exit 0" - should also be 77 instead - and please check
> if there are more (I've not been looking at the source script for lack of time).

Yeah, agreed.  I'm not doing that change in this patch.  But I've
submitted a separate patch fixing all the SKIP places.

Thanks a lot for valuable input!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxr92wACgkQDC186MBRfrrzfgCbBS1r4GuFhNpnqxoxTnwuIctE
GVkAoKAloVAh5CMDQynzB39xaDyXIB9v
=f+Qm
-----END PGP SIGNATURE-----

