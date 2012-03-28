MIME-Version: 1.0
In-Reply-To: <4F72CFC7.8040402@...1114...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
	<1332797200-9295-4-git-send-email-alon.barlev@...277...>
	<4F72CFC7.8040402@...1114...>
Date: Wed, 28 Mar 2012 11:07:09 +0200
Message-ID: <CAOazyz0o-vANXhvmJJj8qjiUZPFMJSHsOTPzr8bOs102kFoxjA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] cleanup: warnings at
	src/openvpn/httpdigest.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Mar 28, 2012 at 10:45 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 26/03/12 23:26, Alon Bar-Lev wrote:
>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...> ---
>> src/openvpn/httpdigest.c | =C2=A0 44
>> ++++++++++++++++++++++---------------------- 1 files changed, 22
>> insertions(+), 22 deletions(-)
>>
>> diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c index
>> 78b8344..a011e56 100644 --- a/src/openvpn/httpdigest.c +++
>> b/src/openvpn/httpdigest.c @@ -76,20 +76,20 @@ DigestCalcHA1( const
>> md_kt_t *md5_kt =3D md_kt_get("MD5");
>>
>> md_ctx_init(&md5_ctx, md5_kt); - =C2=A0md_ctx_update(&md5_ctx, pszUserNa=
me,
>> strlen(pszUserName)); - =C2=A0md_ctx_update(&md5_ctx, ":", 1); -
>> md_ctx_update(&md5_ctx, pszRealm, strlen(pszRealm)); -
>> md_ctx_update(&md5_ctx, ":", 1); - =C2=A0md_ctx_update(&md5_ctx,
>> pszPassword, strlen(pszPassword)); + =C2=A0md_ctx_update(&md5_ctx, (uint=
8_t
>> *)pszUserName, strlen(pszUserName)); + =C2=A0md_ctx_update(&md5_ctx,
>> (uint8_t *)":", 1); + =C2=A0md_ctx_update(&md5_ctx, (uint8_t *)pszRealm,
>> strlen(pszRealm)); + =C2=A0md_ctx_update(&md5_ctx, (uint8_t *)":", 1); +
>> md_ctx_update(&md5_ctx, (uint8_t *)pszPassword, strlen(pszPassword));
>
> My remark here goes to all these type-cast patches [1,2,3].
>
> Wouldn't it be way cleaner to rather fix the function declarations and do
> the proper type-casting in the {crypto,ssl}_{open,polar}ssl.[ch] and
> {crypto,ssl}_backend.h files? =C2=A0Instead of type-casting the whole sou=
rce
> code where such warnings might pop up?

I fixed the smallest chunk I found using sun compiler...

Anyway, I think the use of uint8_t is misleading in this case, buffers
should be declared as (unsigned char *). If you agree to this
statement we need a larger change, I can do this as well.

Most of the code fixed is using standard C string (char *), so casting
will be necessary in either case.

Alon.

