MIME-Version: 1.0
In-Reply-To: <56B0ECA6.3000902@...515...>
References: <56B0ECA6.3000902@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 3 Feb 2016 22:05:38 -0500
Message-ID: <CAKuzo_grryDNAqf1vSoMJUrGVYnZEg_S-GHuZARazjnP5YVsFg@...278...>
Content-Type: multipart/alternative; boundary=001a113d4b907aec24052ae903ec
Subject: Re: [Openvpn-devel] Test installers with the Interactive service /
 Vista-compatible block-outside-dns
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: ValdikSS ValdikSS <iam@...2070...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d4b907aec24052ae903ec
Content-Type: text/plain; charset=UTF-8

Hi,

A second pair of installers contain a patch which makes the new
> --block-outside-dns work with Windows Vista:
>
> <
> http://build.openvpn.net/downloads/temp/openvpn-install-2.3_blockoutsidedns-I601-i686.exe
> >
> <
> http://build.openvpn.net/downloads/temp/openvpn-install-2.3_blockoutsidedns-I601-x86_64.exe
> >
>

I tested this on Windows 10. While it works same as before as far as
blocking dns is concerned, the filter that allows openvpn.exe to do name
resolution through all interfaces does not appear to work.

When a openvpn connection is running with block-outside-dns and no DNS
server is defined on the TAP adapter, all dns queries fail as expected. But
starting a second openvpn.exe also fails at name resolution although the
apparent purpose of the permit filter is to allow that traffic through the
LAN or any other interface

> @@ -1236,26 +1237,44 @@ win_wfp_block_dns (const NET_IFINDEX index)
>      Condition[0].conditionValue.uint16 = 53;
>
>      Condition[1].fieldKey = FWPM_CONDITION_ALE_APP_ID;
> -    Condition[1].matchType = FWP_MATCH_NOT_EQUAL;
> +    Condition[1].matchType = FWP_MATCH_EQUAL;
>      Condition[1].conditionValue.type = FWP_BYTE_BLOB_TYPE;
>      Condition[1].conditionValue.byteBlob = openvpnblob;
>
> Valdikss: Is this filter useful at all? When openvpn does name resolution,
I suppose its the dns client service that would open the port 53 connection.

Selva

--001a113d4b907aec24052ae903ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
A second pair of installers contain a patch which makes the new<br>
--block-outside-dns work with Windows Vista:<br>
<br>
&lt;<a href=3D"http://build.openvpn.net/downloads/temp/openvpn-install-2.3_=
blockoutsidedns-I601-i686.exe" rel=3D"noreferrer" target=3D"_blank">http://=
build.openvpn.net/downloads/temp/openvpn-install-2.3_blockoutsidedns-I601-i=
686.exe</a>&gt;<br>
&lt;<a href=3D"http://build.openvpn.net/downloads/temp/openvpn-install-2.3_=
blockoutsidedns-I601-x86_64.exe" rel=3D"noreferrer" target=3D"_blank">http:=
//build.openvpn.net/downloads/temp/openvpn-install-2.3_blockoutsidedns-I601=
-x86_64.exe</a>&gt;<br></blockquote><div><br></div><div>I tested this on Wi=
ndows 10. While it works same as before as far as blocking dns is concerned=
, the filter that allows openvpn.exe to do name resolution through all inte=
rfaces does not appear to work.<br><br>When a openvpn connection is running=
 with block-outside-dns and no DNS server is defined on the TAP adapter, al=
l dns queries fail as expected. But starting a second openvpn.exe also fail=
s at name resolution although the apparent purpose of the permit filter is =
to allow that traffic through the LAN or any other interface<br><blockquote=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex" class=3D"gmail_quote"><pre>@@ -1236,26 +1237,44 @@ win_wfp=
_block_dns (const NET_IFINDEX index)
     Condition[0].conditionValue.uint16 =3D 53;
=20
     Condition[1].fieldKey =3D FWPM_CONDITION_ALE_APP_ID;
-    Condition[1].matchType =3D FWP_MATCH_NOT_EQUAL;
+    Condition[1].matchType =3D FWP_MATCH_EQUAL;
     Condition[1].conditionValue.type =3D FWP_BYTE_BLOB_TYPE;
     Condition[1].conditionValue.byteBlob =3D openvpnblob;</pre></blockquot=
e></div><div>Valdikss: Is this filter useful at all? When openvpn does name=
 resolution, I suppose its the dns client service that would open the port =
53 connection.<br></div><div><br></div><div>Selva<br></div></div></div></di=
v>

--001a113d4b907aec24052ae903ec--

