Message-ID: <5551BE33.2010208@...1227...>
Date: Tue, 12 May 2015 10:47:47 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <13470069.462428.1431417550257.JavaMail.root@...1893...>
In-Reply-To: <13470069.462428.1431417550257.JavaMail.root@...1893...>
Content-Type: multipart/alternative;
	boundary="------------020606030805060202000707"
Subject: Re: [Openvpn-devel] Request peer review of modified OpenVPN client
 software
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lisa Minogue <lminogue@...1892...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020606030805060202000707
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit



Am 12.05.15 um 09:59 schrieb Lisa Minogue:
> Hi guys,
>
> I obtained a modified OpenVPN client software from a friend and wonder if any of you would like to help review it for security vulnerabilities, design flaws, incorrect implemention of code, etc...
>
> To the best of my knowledge, modifications include the ability to provide obfuscation and avoid deep packet inspection by the Great Firewall.
>
> The URLs to download the two relevant files are:
>
> http://www.datafilehost.com/d/b85faf74
>
> http://www.datafilehost.com/d/930732b4
>
> Thanks in advance.
>
I only took a very brief look: What you gave use is some modified source
code archive that contains some modified OpenVPN source (2.3_git as
version). While most of us developers /could /probably find out which
version that source code is and try to see what the changes our
motivatation to do so is very minimal. We focus on working on the main
source code and review patches for that version.

It has probably some obfuscation/encryption patches applied. There is no
official obfuscation capability in OpenVPN yet since the core OpenVPN
developers believe that such a mechansim should be either implemented in
a plugin or other way (e.g., a proxy) that is flexible enough to change
the mechanism.

Arne

--------------020606030805060202000707
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">Am 12.05.15 um 09:59 schrieb Lisa
      Minogue:<br>
    </div>
    <blockquote
      cite="mid:13470069.462428.1431417550257.JavaMail.root@...1893..."
      type="cite">
      <pre wrap="">Hi guys,

I obtained a modified OpenVPN client software from a friend and wonder if any of you would like to help review it for security vulnerabilities, design flaws, incorrect implemention of code, etc...

To the best of my knowledge, modifications include the ability to provide obfuscation and avoid deep packet inspection by the Great Firewall.

The URLs to download the two relevant files are:

<a class="moz-txt-link-freetext" href="http://www.datafilehost.com/d/b85faf74">http://www.datafilehost.com/d/b85faf74</a>

<a class="moz-txt-link-freetext" href="http://www.datafilehost.com/d/930732b4">http://www.datafilehost.com/d/930732b4</a>

Thanks in advance.

</pre>
    </blockquote>
    I only took a very brief look: What you gave use is some modified
    source code archive that contains some modified OpenVPN source
    (2.3_git as version). While most of us developers <i>could </i>probably
    find out which version that source code is and try to see what the
    changes our motivatation to do so is very minimal. We focus on
    working on the main source code and review patches for that version.<br>
    <br>
    It has probably some obfuscation/encryption patches applied. There
    is no official obfuscation capability in OpenVPN yet since the core
    OpenVPN developers believe that such a mechansim should be either
    implemented in a plugin or other way (e.g., a proxy) that is
    flexible enough to change the mechanism.<br>
    <br>
    Arne<br>
  </body>
</html>

--------------020606030805060202000707--

