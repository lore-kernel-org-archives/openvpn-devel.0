References: <5723626E.3030401@...277...> <57247232.2040608@...515...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <5724B2AA.7020700@...515...>
Date: Sat, 30 Apr 2016 16:27:06 +0300
MIME-Version: 1.0
In-Reply-To: <57247232.2040608@...515...>
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


> Wow. Previously nothing of this magnitude has been encountered. Luckily
> this crap is, afaik, invisible to normal users, because the pages are
> linked to from anywhere (except the TitleIndex).
>
> Based on the history of the spam pages the spammer(s) used many user
> accounts, and the edits were spread over a period of over 32 hours at
> least. Assuming bots have not found a way around the Google reCAPTCHA we
> use in the registration webapp these are real human spammers.
>
> Anyways, I'll turn on a bunch of other spam filtering services in Trac
> today, then add a few more on Monday. I'll also get rid of this crap
> after more spam filtering is in place.
>
> I hope we can avoid the situation where all edits have to be made by
> known-good people. Right now Wiki edits are disabled for everyone except
> a select few.

Hi,

I turned on several new external content scanning spamfilters. In the=20
process I had to upgrade Trac and the Trac spam filtering plugin. We=20
used to only have Akismet, because we didn't really have any big spam=20
issues. Now we have all of these activated:

- Akismet (http://akismet.com/)
- Blogspam (http://blogspam.net/)
- StopForumSpam (http://stopforumspam.com/)
- BotScout (http://botscout.com/)
- Fspamlist (http://www.fspamlist.com/)

Based on spam monitoring and Trac logs the filters seem to work, but=20
we'd need actual spam attempts to prove that[*]. Right now the "karma"=20
setup on Trac is such that if one service thinks the content is spam=20
then the edit will be rejected. I also reduced the maximum number of=20
edits per IP to 5 per hour, and activated Google reCAPTCHA. I did not=20
see reCAPTCHAs, though, when doing ticket test edits, so it might only=20
apply to anonymous edits; in that case it would be useless for us.

There are a few other spam detection services which we can probably=20
activate later:

- Spamwipe (http://spamwipe.com/): registration does not work atm
- Mollom (http://mollom.com/)

I also did a mass removal of the spam Wiki pages (500+). The bastards=20
had contaminated some of our useful Wiki pages, but deducing which ones=20
was fairly easy given direct access to the database. I believe I managed=20
to delete all the contaminated revisions.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[*] I did not want my own IP to get added to various IP blacklists, so I=20
did not try "spamming" myself.

