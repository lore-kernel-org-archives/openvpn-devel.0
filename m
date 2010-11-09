Message-ID: <4CD92714.7030704@...515...>
Date: Tue, 09 Nov 2010 12:48:52 +0200
From: =?ISO-8859-2?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4CD42604.9060104@...515...>
	<4BECF8F2CDD74E4A8127421DB201BA2B0C234B@...1429...>
	<4CD7F9A2.5010804@...1114...>
In-Reply-To: <4CD7F9A2.5010804@...1114...>
Subject: Re: [Openvpn-devel] Preview of OpenVPN 2.1.4 Debian and
	Ubuntu	packages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-2"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> On 08/11/10 11:14, David Bala~ic wrote:
> > Samuli Sepp=E4nen wrote:
>
> >> PS. Also note that our buildbot instance now builds Debian/Ubuntu
> >> packages whenever a commit is made to "allmerged" or
> >> "beta2.2" branches.
> >> These automatically-generated packages are available here:
> >>
> >> <http://build.openvpn.net/downloads/allmerged>
> >> <http://build.openvpn.net/downloads/beta22>
> > The source packages* are from august 21st. Are they not updated?
>
> Humm ... I did update the allmerged branch at the end of October ... so
> this is odd.  Samuli, can you check up if I or the buildsystem failed?
That's normal. I had to disable the automatic package publishing after
initial tests, because there was no sane way to detect if the source
tree had changed after the previous daily packaging&publishing run. I
tried a number of things, but either git or tar/zip caused the package
checksums to not match, even if the sources themselves were 100% the
same. Also, I did not want to clutter build.openvpn.net with packages
that were 90% the same.

Anyways, all of this is fixed now that Buildbot only builds and packages
the sources when it receives a git commit mail.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


