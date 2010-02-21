MIME-Version: 1.0
In-Reply-To: <4B7E71A5.3020806@...1114...>
References: <4B7E71A5.3020806@...1114...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Sun, 21 Feb 2010 12:49:19 +0100
Message-ID: <7bb795fd1002210349j4d5186c1v6fd554addb29fc85@...278...>
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c (was: Re:
	openvpn-testing tree available)
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: Openvpn-devel@lists.sourceforge.net

On Fri, Feb 19, 2010 at 12:10 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi guys!
> On 18/02/10 22:45, JuanJo Ciarlante wrote:
>> On Wed, Feb 17, 2010 at 6:46 PM, JuanJo Ciarlante <jjo+ml@...410...>
> wrote:
>>
>>> I still need to do some touches for allmerged, as
>>> we conflict w/ Gert's IPv6 patch on a mroute.c chunk
>>> IIRC.
>>
>
> Even though I know you both have told me that there would be a merge
> conflict in mroute.c, I decided to put it on the mailing list -
> hopefully to get an open discussion about it!
>
> I've attached the merge conflict. =A0It would be great if you could sort
> this out soon. =A0Then I'll get both of your trees into the allmerged
> branch ASAP. =A0Right now only Gert's code is in the allmerged branch.
>
> What I do see might be a challenge (without knowing the code in
> details), is that JJO's code is using #ifdef, while Gert's code is not.
> =A0With a conflict in mroute_addr_print_ex(), which includes an #ifdef I
> see a potential disaster here.
>
> Personally, I would like to evaluate Gert's patches to see if they could
> be #ifdef'ed. =A0Then both IPv6 branches can both use USE_PF_INET6 to
> enable or disable the IPv6 support.

IMHO they should have different #ifdef'ing, coming from eg:
  ../configure --enable-ipv6-transport --enable-ipv6-payload
, mainly to ease future debugging, and to motivate wider audience
thinking of:
* different OSes (ipv6-transport builds and (probably)runs in windowze)
* distros like Gentoo, already carrying ipv6-transport, may want to add a
   build option for the payload patch.
* size constraints (embeeded like eg. freetz.org)
* USE_PF_INET6 clearly speaks "transport" in its very name :)

> =A0I have not studied these patches,
> so I don't know how doable that is. =A0And this is my personal opinion, I
> don't mean to instruct anyone into a direction. =A0I will let you guys
> find the proper direction.
>
>
> kind regards,
>
> David Sommerseth
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.10 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAkt+caIACgkQDC186MBRfrr5ZACgqLxiXN70pCOGY0zyvQGSCpo6
> n2EAn1le6hzZe4aThLfAKvYwK7d3CPSG
> =3De7yX
> -----END PGP SIGNATURE-----
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

