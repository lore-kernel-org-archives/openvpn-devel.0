Message-ID: <42032FDD.50002@...348...>
From: Patrick Steiner <steiner@...348...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Re: OpenVPN with OPIE (One Time Passwords in
 Everything) ??
References: <4202350D.4020708@...348...> <pan.2005.02.03.18.39.30.133381@...294...> <Pine.LNX.4.58.0502031317270.23846@...41...>
In-Reply-To: <Pine.LNX.4.58.0502031317270.23846@...41...>
Content-Type: multipart/alternative;
 boundary="------------050406000905080000000505"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Fri Feb  4 00:19:37 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050406000905080000000505
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.hispeed.ch id j148Ib65022336
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Yes thats what i need, thanks james!

James Yonan wrote:

>On Thu, 3 Feb 2005, Charles Duffy wrote:
>
>=20=20
>
>>On Thu, 03 Feb 2005 15:28:29 +0100, Patrick Steiner wrote:
>>
>>=20=20=20=20
>>
>>>Is it possible to use OpenVPN with OPIE (One Time Passwords in
>>>Everything) What i want is to connect from a windows client to a linux
>>>server. But for OPIE i need a interactive password authentication. this
>>>means: the server send password string an the user at the client side
>>>give his password based on the string from the server. Is this possible
>>>to inplement?
>>>=20=20=20=20=20=20
>>>
>>It's already implemented. See auth-user-pass and auth-user-pass-verify.
>>=20=20=20=20
>>
>
>Right, but I think he's asking for a challenge/response mechanism, which=20
>doesn't yet exist.
>
>The server would need to generate a challenge string and send it to the
>client BEFORE the client-user enters the password.  It could be done but=20
>would require a patch.
>
>James
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>Tool for open source databases. Create drag-&-drop reports. Save time
>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>_______________________________________________
>Openvpn-devel mailing list
>Openvpn-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>=20=20
>

--=20
******************************************************
*  Patrick Steiner
*
*  AlpNET Engineering AG - CyberMedia Gesamtl=F6sungen
*  Laurenzgasse 5, 8006 Z=FCrich
*
*  Telefon +41(0)1 360 8030
*  Direkt  +41(0)1 360 8034
*  Fax     +41(0)1 360 8031
*
*  steiner@...348..., http://www.alpnet.ch
******************************************************


--------------050406000905080000000505
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Yes thats what i need, thanks james!<br>
<br>
James Yonan wrote:
<blockquote cite="midPine.LNX.4.58.0502031317270.23846@...41..."
 type="cite">
  <pre wrap="">On Thu, 3 Feb 2005, Charles Duffy wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">On Thu, 03 Feb 2005 15:28:29 +0100, Patrick Steiner wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">Is it possible to use OpenVPN with OPIE (One Time Passwords in
Everything) What i want is to connect from a windows client to a linux
server. But for OPIE i need a interactive password authentication. this
means: the server send password string an the user at the client side
give his password based on the string from the server. Is this possible
to inplement?
      </pre>
    </blockquote>
    <pre wrap="">It's already implemented. See auth-user-pass and auth-user-pass-verify.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Right, but I think he's asking for a challenge/response mechanism, which 
doesn't yet exist.

The server would need to generate a challenge string and send it to the
client BEFORE the client-user enters the password.  It could be done but 
would require a patch.

James



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&amp;-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at <a class="moz-txt-link-freetext"
 href="http://www.intelliview.com/go/osdn_nl">http://www.intelliview.com/go/osdn_nl</a>
_______________________________________________
Openvpn-devel mailing list
<a class="moz-txt-link-abbreviated"
 href="mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext"
 href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>

  </pre>
</blockquote>
<br>
<pre class="moz-signature" cols="72">-- 
******************************************************
*  Patrick Steiner
*
*  AlpNET Engineering AG - CyberMedia Gesamtl&ouml;sungen
*  Laurenzgasse 5, 8006 Z&uuml;rich
*
*  Telefon +41(0)1 360 8030
*  Direkt  +41(0)1 360 8034
*  Fax     +41(0)1 360 8031
*
*  <a class="moz-txt-link-abbreviated" href="mailto:steiner@...348...">steiner@...348...</a>, <a
 class="moz-txt-link-freetext" href="http://www.alpnet.ch">http://www.alpnet.ch</a>
******************************************************</pre>
</body>
</html>

--------------050406000905080000000505--

