Message-ID: <4B5963D5.30305@...515...>
Date: Fri, 22 Jan 2010 10:37:41 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4B570C63.1050808@...515...>
	<20100120193247.GL857@...1296...>
In-Reply-To: <20100120193247.GL857@...1296...>
Subject: Re: [Openvpn-devel] OpenVPN core development processes?
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Wed, Jan 20, 2010 at 04:00:03PM +0200, Samuli Sepp=E4nen wrote:
>=20=20=20
>> So something like this at first:
>>
>> http://users.utu.fi/sjsepp/openvpn/process_contributing_to_openvpn.png
>>
>> ... and later this:
>>
>> http://users.utu.fi/sjsepp/openvpn/process_contributing_to_openvpn_2.png
>>=20=20=20=20=20
>
> This makes sense to me.  Especially since there is well-defined feedback
> to the patch author what will happen with his work.
>
>=20=20=20
>> The second process avoids unnecessary bottlenecks. Perhaps we could also
>> have separate "experimental", "unstable" or "feature-testing" trees
>> maintained by other people. The code from these would then flow into the
>> main development tree. I believe these trees could we managed with Git
>> even if the main development branch is in SVN.
>>=20=20=20=20=20
>
> The nice thing about git is that people can very easily do "experimental=
=20
> branches" in their own repository, giving access to testers, without=20
> having to have write access to SVN.
>
> OTOH, the VCS used is just a tool to help the process, and not the
> primary goal :-) - so I'm definitely not going to be religious about
> git or svn or cvs or...
>
> gert
>=20=20=20
Ok, we can test the processes and adjust as necessary. James needs to
take the initiative here.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


