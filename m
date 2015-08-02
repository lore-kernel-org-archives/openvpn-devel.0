Message-ID: <55BE00D1.4060900@...515...>
Date: Sun, 02 Aug 2015 14:36:49 +0300
From: =?windows-1252?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <20150730233727.GW3676@...2049...>	<CAFHpkQGqdJdpz_FTPWzsziNHbMCt3DOwkLHA8BXU9M+-+Cv_mA@...278...>	<20150731091257.GC3164@...2050...>	<CAFHpkQFk5nB9U655hh3TKn_BsVVBR_q8tibVDc7XhYTgKC1Jkg@...278...>	<20150731095726.GL3164@...2050...>
	<20150801130709.GM382@...1296...>
In-Reply-To: <20150801130709.GM382@...1296...>
Subject: Re: [Openvpn-devel] Packet loss due to radius issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, Samuel Thibault <samuel.thibault@...1817...>, ???????? ?????????????? <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Fri, Jul 31, 2015 at 11:57:26AM +0200, Samuel Thibault wrote:
>> But without a central repository where people would get to know about
>> your version, then it's even more probable that you'll remain the only
>> user...
>
> Indeed.  Who *is* maintaining the radius plugin these days?  What is
> "the official" repo?
>
> I found some stuff on
>
> http://www.nongnu.org/radiusplugin/
>
> (no change since 2010, but the debian package has "more recent" updates,
> and the ubuntu package even has a patch from Samuel Thibault :-) )
>
> http://www.bytebucket.org/02strich/openvpn-auth-radius/src
>
> (this seems to be a fork, many of the files have the commit message
> "initial commit - based on 2.1 Beta", but there has been a bit of activity
> in 2012 and 2014...  not very much, so merging the stuff back should not
> be very hard)
>
> gert

Maybe we should create an official repository for the RADIUS plugin,=20
say, on GitHub? We could collect all the patches in there and if=20
somebody wants to maintain it we could grant access to that (sub)project=20
only.

Thoughts?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

