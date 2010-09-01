MIME-Version: 1.0
In-Reply-To: <20100901135851.GW10703@...1296...>
References: <AANLkTinjxHX-3baqYZARRT3SpYae8a-44CXNPkTXBXtC@...278...>
	<20100901135851.GW10703@...1296...>
Date: Wed, 1 Sep 2010 16:21:53 +0200
Message-ID: <AANLkTi=uKEMyK0eKZR8UKShAxm2Dy6oRJqtsPvBDqJ3W@...278...>
From: Allan Swanepoel <allanice001@...277...>
Subject: Re: [Openvpn-devel] Compiling OpenVPN for Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Sep 1, 2010 at 3:58 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Wed, Sep 01, 2010 at 02:58:59PM +0200, Allan Swanepoel wrote:
>> Hi All, I'm fairly new to building openvpn for windows (have been
>> building on Linux since 2.0),
>> I have a small customization that I make to the openvpn sourcecode to
>> call external software on initialization, and would like to build a
>> Windows build with this in.
>
> You can do two things - cross-build with mingw under linux (producing
> openvpn.exe binaries for windows), or build with mingw+msys under
> windows.
>
> If you want to do the latter, read the file "domake-win" in the OpenVPN
> source tree - it's the script that does the windows building, and it
> contains the instructions as well.
>
> If you use the pre-compiled tun/tap driver from the 2.1.3 windows
> bundle, you don't need the MS DDK/WDK, just msys+mingw and the NSIS
> installer-builder.

Won't msys & mingw then become dependencies for running openvpn?

>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 gert@...1296...
> fax: +49-89-35655025 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gert@=
...1297...
>



--=20
We live in an age when pizza gets to your home before the police.
=A0 - Jeff Marder
------------------------------------------
Allan Swanepoel
allanice001@...277...
allanice.001@...1202...
dragonmaster@...1203...
+27 71 850 5554
Linux User #452990
Linux Machine #360914
-----------------------------------------------
IMPORTANT: This email is intended for the use of=A0 the=A0 individual
addressee(s)=A0 named=A0 above=A0 and=A0 may=A0 contain information that is
confidential,=A0 privileged=A0 or=A0 unsuitable=A0 for=A0 overly=A0 sensiti=
ve
persons=A0 with=A0 low=A0 self-esteem, no sense of humour or irrational
religious beliefs. If you are not=A0 the=A0 intended=A0 recipient,=A0 any
dissemination,=A0 distribution=A0 or copying=A0 of=A0 this=A0 email is not
authorised (either explicitly or implicitly) and=A0 constitutes=A0 an
irritating=A0 social=A0 faux=A0 pas. Unless the word absquatulation has been
used in its correct context somewhere=A0 other=A0 than=A0 in=A0 this warnin=
g,
it does not have any legal or grammatical use and may be ignored. No
animals were=A0 harmed=A0 in=A0 the=A0 transmission=A0 of=A0 this email,=A0=
 although
 the=A0 yorkshire=A0 terrier=A0 next door is living on borrowed time, let me
tell you. Those of you with an overwhelming fear=A0 of=A0 the unknown will
be gratified to learn that there is no hidden message revealed by
reading=A0 this=A0 warning=A0 backwards,=A0 so just ignore that Alert Notice
from Microsoft: However, by pouring a complete circle of salt around
yourself and your=A0 computer=A0 you can=A0 ensure=A0 that=A0 no harm befal=
ls
you and your pets.

