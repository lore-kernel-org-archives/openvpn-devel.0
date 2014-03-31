MIME-Version: 1.0
In-Reply-To: <53391C5C.90705@...1147...>
References: <1396001222-5033-1-git-send-email-arne@...1227...>
	<CAA1AbxJCv9ff7XHv1GKtCPuB-Hc5Lv33ufPfqcTraNpFnJf7fw@...278...>
	<20140330134619.GT16637@...1296...> <53391C5C.90705@...1147...>
From: Steffan Karger <steffan@...1856...>
Date: Mon, 31 Mar 2014 10:34:35 +0200
Message-ID: <CAA1AbxJ8=_2ZPGGME1-EN6ZAqcCMnMv+aup8s4EpB7knEdeTfg@...278...>
Content-Type: multipart/alternative; boundary=001a11c238b816407804f5e2ede1
Subject: Re: [Openvpn-devel] [PATCH] Fix man page and OSCP script:
 tls_serial_{n} is decimal
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11c238b816407804f5e2ede1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

On Mon, Mar 31, 2014 at 9:42 AM, Jan Just Keijser <janjust@...1147...> wrote:

> On 30/03/14 15:46, Gert Doering wrote:
>
>> Hi,
>>
>> On Sun, Mar 30, 2014 at 12:48:37AM +0100, Steffan Karger wrote:
>>
>>> 3 - Change OpenSSL builds to use hax representation
>>>
>> I tend toward this one - user visible behaviour shouldn't change (unless
>> unavoidable) depending on SSL library used.
>>
>> So for me this boils down to "how many users are relying on the current
>> behaviour, which is not what the docs say it should be"?
>>
>>
>>  I've posted a script to verify CRLs
>   http://www.nikhef.nl/~janjust/vpn/OpenVPN2-Cookbook/verify-crls.sh
> which relies on the XX:XX:XX format ... I could change that, of course,
> but I am not sure how many people are actually using that script.
> Printing the serial in hex format would make it more difficult to do a CRL
> check, however, as the openssl tools by default use the XX:XX:XX format.
>

If I try 'openssl crl -noout -text -in some.crl', the serial output reads
as XX:XX:XX, but is in hex, not decimal form. That makes me believe this
script was broken by the hex -> decimal change (and thus probably isn't
used very much in combination with openvpn 2.2 or 2.3). So this, too, votes
for 'make OpenSSL builds use hex again'.

-Steffan

--001a11c238b816407804f5e2ede1
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Mon, Mar 31, 2014 at 9:42 AM, Jan Just Keijser <span dir=3D"=
ltr">&lt;<a href=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1186...=
.1147...</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On 30/03/14 15:46, Gert Doer=
ing wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
On Sun, Mar 30, 2014 at 12:48:37AM +0100, Steffan Karger wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
3 - Change OpenSSL builds to use hax representation<br>
</blockquote>
I tend toward this one - user visible behaviour shouldn&#39;t change (unles=
s<br>
unavoidable) depending on SSL library used.<br>
<br>
So for me this boils down to &quot;how many users are relying on the curren=
t<br>
behaviour, which is not what the docs say it should be&quot;?<br>
<br>
<br>
</blockquote></div>
I&#39;ve posted a script to verify CRLs<br>
=A0 <a href=3D"http://www.nikhef.nl/~janjust/vpn/OpenVPN2-Cookbook/verify-c=
rls.sh" target=3D"_blank">http://www.nikhef.nl/~janjust/<u></u>vpn/OpenVPN2=
-Cookbook/verify-<u></u>crls.sh</a><br>
which relies on the XX:XX:XX format ... I could change that, of course, but=
 I am not sure how many people are actually using that script.<br>
Printing the serial in hex format would make it more difficult to do a CRL =
check, however, as the openssl tools by default use the XX:XX:XX format.<br=
></blockquote></div><br></div><div class=3D"gmail_extra">If I try &#39;open=
ssl crl -noout -text -in some.crl&#39;, the serial output reads as XX:XX:XX=
, but is in hex, not decimal form. That makes me believe this script was br=
oken by the hex -&gt; decimal change (and thus probably isn&#39;t used very=
 much in combination with openvpn 2.2 or 2.3). So this, too, votes for &#39=
;make OpenSSL builds use hex again&#39;.<br>

<br>-Steffan<br></div></div></div>

--001a11c238b816407804f5e2ede1--

