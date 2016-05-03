References: <5723626E.3030401@...277...> <57247232.2040608@...515...>
	<5724B2AA.7020700@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <57284BBE.2040907@...515...>
Date: Tue, 3 May 2016 09:57:02 +0300
MIME-Version: 1.0
In-Reply-To: <5724B2AA.7020700@...515...>
Subject: Re: [Openvpn-devel] SPAM on trac
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
To: debbie10t <debbie10t@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

> Hi,
>
> I turned on several new external content scanning spamfilters. In the
> process I had to upgrade Trac and the Trac spam filtering plugin. We
> used to only have Akismet, because we didn't really have any big spam
> issues. Now we have all of these activated:
>
> - Akismet (http://akismet.com/)
> - Blogspam (http://blogspam.net/)
> - StopForumSpam (http://stopforumspam.com/)
> - BotScout (http://botscout.com/)
> - Fspamlist (http://www.fspamlist.com/)
>
> Based on spam monitoring and Trac logs the filters seem to work, but
> we'd need actual spam attempts to prove that[*]. Right now the "karma"
> setup on Trac is such that if one service thinks the content is spam
> then the edit will be rejected. I also reduced the maximum number of
> edits per IP to 5 per hour, and activated Google reCAPTCHA. I did not
> see reCAPTCHAs, though, when doing ticket test edits, so it might only
> apply to anonymous edits; in that case it would be useless for us.
>
> There are a few other spam detection services which we can probably
> activate later:
>
> - Spamwipe (http://spamwipe.com/): registration does not work atm
> - Mollom (http://mollom.com/)
>
> I also did a mass removal of the spam Wiki pages (500+). The bastards
> had contaminated some of our useful Wiki pages, but deducing which ones
> was fairly easy given direct access to the database. I believe I managed
> to delete all the contaminated revisions.
>

Hi,

I setup urlwatch to watch the "Recent changes" page every ten minutes:

<https://community.openvpn.net/openvpn/wiki/RecentChanges>

Adding, deleting or modifying a Wiki page will now trigger an email=20
notification. The attack such as the last one would have triggered a=20
huge number of emails and would have allowed us respond much faster. The=20
Trac front page has been successfully monitored for a long while,=20
resulting in removal of quite a bit of attachment spam. Notifications to=20
Trac tickets are already sent to #openvpn-devel IRC channel, so that=20
part is covered already.

Right now the notification emails go only to me, but sending them to=20
additional people would improve our response time. I don't expect a huge=20
number of emails, even though RecentChanges page will see more activity=20
than Wikistart.

Let me know if you want to help monitor the Wiki and I'll add your email=20
to the urlwatch list.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

