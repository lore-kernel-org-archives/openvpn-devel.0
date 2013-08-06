Message-ID: <520100E6.8020700@...515...>
Date: Tue, 06 Aug 2013 16:57:58 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAMaBZnHDPHTpPmFoLbyDHxKnBwm7PdPDouZi99bgQzrA9=eXDw@...278...>
	<20130529122956.GH20843@...1296...>
	<20130529133817.GG6942@...1330...>
	<CAMaBZnFwr4iMVTg4QSkosMYsqnpq5-_rt9eny-O9fCSLFLoiqg@...278...>
	<20130529185003.GJ20843@...1296...>
	<CAMaBZnFVPuyUDRwKu0qiOLRdZwhmJXiho=29keGvft=fvBA6Sw@...278...>
	<51A75F21.4060200@...515...>
	<C1340C42-3C88-415C-A51D-3ECC16DFE1B8@...277...>
	<51A855E2.1040201@...515...>
	<CAMaBZnGKUp6v0UhVQ0SQhO1roXtWZkw7JLeBLkFO9-b-4j4qVg@...278...>
In-Reply-To: <CAMaBZnGKUp6v0UhVQ0SQhO1roXtWZkw7JLeBLkFO9-b-4j4qVg@...278...>
Content-Type: multipart/alternative;
	boundary="------------010505030208060507040502"
Subject: Re: [Openvpn-devel] Repos for Debian Wheezy?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Praetorian <praetoriancode@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010505030208060507040502
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm in the process of creating a bunch of chroot environments to replace
my dedicated build VMs, so that I can more easily package OpenVPN for
the following operating systems:

- Debian Squeeze (6.x)
- Debian Wheezy (7.x)
- Ubuntu 10.04
- Ubuntu 12.04
- Ubuntu 12.10
- Ubuntu 13.04
- Fedora 19
- CentOS 6

All packages will be available in 32-bit and 64-bit versions. The
packages will be hosted in apt/yum repos, and both stable builds (e.g.
2.3.2) and testing versions (e.g. 2.4-alpha1) will be available. I can't
give any exact time when all this - and Debian Wheezy packages - will be
ready, but I suppose ~3 weeks is a fair guess.

If you're in a hurry, you should be able to fairly easily built packages
for Wheezy. All the packaging files used with official packages are
available here:

<https://github.com/mattock/openvpn-build>

You basically just need to modify the control files to make OpenVPN
depend on a later openssl version and rebuild it. There is plenty of
fairly good documentation available, which should get you started.

Samuli


> I hate to revive an old email chain, but has there been any progress
> in creating a snapshot package for Wheezy.
>
>
> Thank you.=20=20=20
>
>
> On Fri, May 31, 2013 at 3:48 AM, Samuli Sepp=E4nen <samuli@...515...
> <mailto:samuli@...515...>> wrote:
>
>
>>     Does that mean you will be building packages against libssl1.0.0?
>>
>     Yes. Wheezy does not seem to have libssl0.9.8 available, which is
>     probably the primary/only reason why my snapshot packages for
>     Squeeze don't work on Wheezy.
>
>     Samuli
>
>



--------------010505030208060507040502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi,<br>
      <br>
      I'm in the process of creating a bunch of chroot environments to
      replace my dedicated build VMs, so that I can more easily package
      OpenVPN for the following operating systems:<br>
      <br>
      - Debian Squeeze (6.x)<br>
      - Debian Wheezy (7.x)<br>
      - Ubuntu 10.04<br>
      - Ubuntu 12.04<br>
      - Ubuntu 12.10<br>
      - Ubuntu 13.04<br>
      - Fedora 19<br>
      - CentOS 6<br>
      <br>
      All packages will be available in 32-bit and 64-bit versions. The
      packages will be hosted in apt/yum repos, and both stable builds
      (e.g. 2.3.2) and testing versions (e.g. 2.4-alpha1) will be
      available. I can't give any exact time when all this - and Debian
      Wheezy packages - will be ready, but I suppose ~3 weeks is a fair
      guess.<br>
      <br>
      If you're in a hurry, you should be able to fairly easily built
      packages for Wheezy. All the packaging files used with official
      packages are available here:<br>
      <br>
      <a class="moz-txt-link-rfc2396E" href="https://github.com/mattock/openvpn-build">&lt;https://github.com/mattock/openvpn-build&gt;</a><br>
      <br>
      You basically just need to modify the control files to make
      OpenVPN depend on a later openssl version and rebuild it. There is
      plenty of fairly good documentation available, which should get
      you started.<br>
      <br>
      Samuli<br>
      <br>
      <br>
    </div>
    <blockquote
cite="mid:CAMaBZnGKUp6v0UhVQ0SQhO1roXtWZkw7JLeBLkFO9-b-4j4qVg@...278..."
      type="cite">
      <div dir="ltr">I hate to revive an old email chain, but has there
        been any progress in creating a snapshot package for Wheezy.
        <div><br>
        </div>
        <div><br>
        </div>
        <div style="">Thank you. &nbsp;&nbsp;</div>
      </div>
      <div class="gmail_extra"><br>
        <br>
        <div class="gmail_quote">On Fri, May 31, 2013 at 3:48 AM, Samuli
          Sepp&auml;nen <span dir="ltr">&lt;<a moz-do-not-send="true"
              href="mailto:samuli@...515..." target="_blank">samuli@...515...</a>&gt;</span>
          wrote:<br>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div text="#000000" bgcolor="#FFFFFF">
              <div class="im">
                <div><br>
                </div>
                <blockquote type="cite">
                  <div>Does that mean you will be building packages
                    against libssl1.0.0?<br>
                    <br>
                  </div>
                </blockquote>
              </div>
              Yes. Wheezy does not seem to have libssl0.9.8 available,
              which is probably the primary/only reason why my snapshot
              packages for Squeeze don't work on Wheezy.<span
                class="HOEnZb"><font color="#888888"><br>
                  <br>
                  Samuli<br>
                </font></span></div>
          </blockquote>
        </div>
        <br>
      </div>
    </blockquote>
    <br>
    <br>
  </body>
</html>

--------------010505030208060507040502--

