Message-ID: <4E17B5BF.2030309@...1147...>
Date: Sat, 09 Jul 2011 03:58:23 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4E1626B5.30803@...515...>
In-Reply-To: <4E1626B5.30803@...515...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (7th July 2011)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

dazo wrote:

> dazo 12:16:09
> we need to catch up on janjust on that one ... I think he dropped the bal=
l due to holiday season or so ... I think it's been quite quiet from him la=
tely (esp. here on IRC)=09

yep - I'm on holidays right now and I have not had the time to look into=20
this further ;  I still want to build my own tap-win32 driver to see if=20
I can get some more info on what is causing the DHCPNAK bomb. I hope to=20
be able to get to that in august.

cheers,

JJK


Samuli Sepp=E4nen wrote:
> Hi,
>
> Here's the summary of the previous community meeting.
>
> ---
>
> COMMUNITY MEETING
>
> Place: #openvpn-devel on irc.freenode.net
> Date: Thursday, 7th July 2011
> Time: 18:00 UTC
>
> Planned meeting topics for this meeting were on this page:
>
> <https://community.openvpn.net/openvpn/wiki/Topics-2011-07-07>
>
> Next meeting will be announced in advance, but will be on the same
> weekday and at the same time. Your local meeting time is easy to check
> from services such as
>
> <http://www.timeanddate.com/world clock>
>
> or with
>
> $ date -u
>
>
> SUMMARY
>
> andj, dazo, ecrist, jamesyonan and mattock were present in this
> meeting.
>
> --
>
> Discussed issues of building OpenVPN from the "tmp/winbuildfix" branch
> in openvpn-testing.git. Noticed that there was a simple typo that
> triggered the only remaining error in win32.h. Mattock will fix this and
> provide a patch.
>
> --
>
> Discussed the "IPV6_RECVPKTINFO vs. IPV6_PKTINFO" patch:
>
> <http://sourceforge.net/mailarchive/message.php?msg_id=3D27714628>
>
> Decided to take this up with jjo and cron2, as they're responsible for
> the IPv6 code in OpenVPN.
>
> --
>
> Discussed "Bug: extended x509-username-field broken in git" patch:
>
> <http://thread.gmane.org/gmane.network.openvpn.devel/4801>
>
> Andj had provided a fix to the same issue earlier than Markus, so it was
> decided to implement andj's version.
>
> --
>
> Discussed andj's doxygen patchset:
>
> <http://thread.gmane.org/gmane.network.openvpn.devel/4740>
>
> Jamesyonan gave this patchset his ACK, provided that it does not change
> any functionality. Dazo will verify that and then merge the patches to Gi=
t.
>
> --
>
> Discussed the possibility of arranging "sprints" where large patchsets
> (such as andj's) would be reviewed, fixed and ACKed in one go. The
> patches would still be first published on the mailinglist and would not
> be merged into Git until a summary of each sprint session was sent to
> the mailinglist for review. This would allow input even from those who
> were unable to attend the actual sprint.
>
> Smaller patchsets and single patches would still be handled through the
> mailinglist. If they stayed there for too long (1-2 weeks) without any
> comments, they could be handled in a sprint, too. Also, whenever
> possible, a poll (e.g. Doodle) would be arranged prior to sprint, so
> that as many developers as possible could attend.
>
> The Gerrit tool was mentioned, too, as a tool we could potentially use
> to ease the patch review process:
>
> <http://code.google.com/p/gerrit>
>
> --
>
> Decided to arrange the next meeting next Thursday, but 1 hour earlier
> that usual (17:00 UTC). The meeting would also include a sprint.
>
> ---
>
> Full chatlog as an attachment
>
>=20=20=20
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------=
-----
> All of the data generated in your IT infrastructure is seriously valuable.
> Why? It contains a definitive record of application performance, security=
=20
> threats, fraudulent activity, and more. Splunk takes this data and makes=
=20
> sense of it. IT sense. And common sense.
> http://p.sf.net/sfu/splunk-d2d-c2
> ------------------------------------------------------------------------
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


