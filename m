Message-ID: <4CD92573.5080804@...515...>
Date: Tue, 09 Nov 2010 12:41:55 +0200
From: =?ISO-8859-2?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4CD42604.9060104@...515...>
	<4BECF8F2CDD74E4A8127421DB201BA2B0C234B@...1429...>
In-Reply-To: <4BECF8F2CDD74E4A8127421DB201BA2B0C234B@...1429...>
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
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Samuli Sepp=E4nen wrote:
>=20=20
>=20=20=20
>> PS. Also note that our buildbot instance now builds Debian/Ubuntu
>> packages whenever a commit is made to "allmerged" or=20
>> "beta2.2" branches.
>> These automatically-generated packages are available here:
>>
>> <http://build.openvpn.net/downloads/allmerged>
>> <http://build.openvpn.net/downloads/beta22>
>>=20=20=20=20=20
>
> The source packages* are from august 21st. Are they not updated?
>
> Regards,
> David
>
>=20=20=20
Hi David,

Unlike I said in my earlier email, the actual automatic package
_publishing_ (deb, tar.gz, zip) is disabled. The reason is that up until
recently Buildbot could not trigger a build automatically when a commit
was made to the Git repository. That's fixed now, but I'm still waiting
for dazo to push real (=3Dnon-artificial) commits to "allmerged" and
"beta2.2" branches to see if my GitMaildirSource buildbot class works as
expected. After this I can automate the publishing part in this puzzle :).

I'll let you know when the whole process (git commit -> build+packaging
-> publishing) is working as expected. Sorry for the previous, confusing
email...

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


