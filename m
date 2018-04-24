Message-ID: <93ac3d2a9b3c523e97e2e9123f38e2ea.squirrel@...2260...>
In-Reply-To: <4a54f829-1f12-4f1e-baf7-8fc93c5c4885@...515...>
References: <b7bfc99a-51e5-0fa7-9598-067a264564a6@...515...>
 <4a54f829-1f12-4f1e-baf7-8fc93c5c4885@...515...>
Date: Tue, 24 Apr 2018 11:33:19 +0200
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 18th Apr 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?utf-8?B?IlNhbXVsaSBTZXBww6RuZW4i?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

I'm just wondering what happened to the proposed 2.4.6 release? Will it
come anytime soon?

Regards,
Simon

> Hi,
>
> Here's the summary of the IRC meeting.
> ---
>
> COMMUNITY MEETING
>
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wednesday 18th Apr 2018
> Time: 11:30 CET (10:30 UTC)
>
> Planned meeting topics for this meeting were here:
>
> <https://community.openvpn.net/openvpn/wiki/Topics-2018-04-18>
>
> The next meeting has not been scheduled yet.
>
> Your local meeting time is easy to check from services such as
>
> <http://www.timeanddate.com/worldclock>
>
> SUMMARY
>
> cron2, dazo, mattock, ordex, plaisthos and syzzer participated in
> this meeting.
>
> --
>
> Discussed upcoming OpenVPN 2.4.6 release. It will contain what
> release/2.4 has now, plus one security fix which is under embargo. The
> tree will be pushed to buildbot tomorrow afternoon after which the
> release machinery starts for good.
>
> The 2.4.6 release will include an updated tap-windows6 driver with a
> small security fix. The fix will not get a CVE as exploitation requires
> local admin privileges and is not remotely exploitable. It was agreed
> that we should update PRODUCT_VERSION in tap-windows6 from 9,0,0,21 to
> 9,22,1,601. This means it will be in-line with the real version
> (9.22.1). The old, confusing PRODUCT_VERSION string seems to be just
> historic baggage brought over from tap-windows (i.e. the old NDIS 5
> driver).
>
> --
>
> Discussed unit testing the netlink code and in particular the msg()
> function. Noted that we have mock_msg.c already which does minimal
> logging, which renders it more suitable for unit testing.
>
> --
>
> Discussed the location of the next hackathon. One possibility is Lviv,
> Ukraine, where OpenVPN Inc. has a rather large team. It is easily
> accessible for EU citizens as no visa is required.
>
> ---
>
> Full chatlog attached.
>
> --
> Samuli Seppänen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org!
> http://sdm.link/slashdot_______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>



