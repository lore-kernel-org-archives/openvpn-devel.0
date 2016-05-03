MIME-Version: 1.0
Date: Tue, 03 May 2016 11:34:28 -0500
From: ecrist@...1286...
In-Reply-To: <572891FA.7000303@...515...>
References: <5723626E.3030401@...277...> <57247232.2040608@...515...>
	<5724B2AA.7020700@...515...> <57284BBE.2040907@...515...>
	<572891FA.7000303@...515...>
Message-ID: <78a906a0e0ff5db7a601d2a3098c1dbd@...1286...>
Subject: Re: [Openvpn-devel] SPAM on trac
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

On 2016-05-03 06:56, Samuli Sepp=C3=A4nen wrote:
>>> Hi,
>>>=20
>>> I turned on several new external content scanning spamfilters. In the
>>> process I had to upgrade Trac and the Trac spam filtering plugin. We
>>> used to only have Akismet, because we didn't really have any big spam
>>> issues. Now we have all of these activated:
>>>=20
>>> - Akismet (http://akismet.com/)
>>> - Blogspam (http://blogspam.net/)
>>> - StopForumSpam (http://stopforumspam.com/)
>>> - BotScout (http://botscout.com/)
>>> - Fspamlist (http://www.fspamlist.com/)
>>>=20
>>> Based on spam monitoring and Trac logs the filters seem to work, but
>>> we'd need actual spam attempts to prove that[*]. Right now the=20
>>> "karma"
>>> setup on Trac is such that if one service thinks the content is spam
>>> then the edit will be rejected. I also reduced the maximum number of
>>> edits per IP to 5 per hour, and activated Google reCAPTCHA. I did not
>>> see reCAPTCHAs, though, when doing ticket test edits, so it might=20
>>> only
>>> apply to anonymous edits; in that case it would be useless for us.
>>>=20
>>> There are a few other spam detection services which we can probably
>>> activate later:
>>>=20
>>> - Spamwipe (http://spamwipe.com/): registration does not work atm
>>> - Mollom (http://mollom.com/)
>>>=20
>>> I also did a mass removal of the spam Wiki pages (500+). The bastards
>>> had contaminated some of our useful Wiki pages, but deducing which=20
>>> ones
>>> was fairly easy given direct access to the database. I believe I=20
>>> managed
>>> to delete all the contaminated revisions.
>>>=20
>>=20
>> Hi,
>>=20
>> I setup urlwatch to watch the "Recent changes" page every ten minutes:
>>=20
>> <https://community.openvpn.net/openvpn/wiki/RecentChanges>
>>=20
>> Adding, deleting or modifying a Wiki page will now trigger an email
>> notification. The attack such as the last one would have triggered a
>> huge number of emails and would have allowed us respond much faster.=20
>> The
>> Trac front page has been successfully monitored for a long while,
>> resulting in removal of quite a bit of attachment spam. Notifications=20
>> to
>> Trac tickets are already sent to #openvpn-devel IRC channel, so that
>> part is covered already.
>>=20
>> Right now the notification emails go only to me, but sending them to
>> additional people would improve our response time. I don't expect a=20
>> huge
>> number of emails, even though RecentChanges page will see more=20
>> activity
>> than Wikistart.
>>=20
>> Let me know if you want to help monitor the Wiki and I'll add your=20
>> email
>> to the urlwatch list.
>>=20
>=20
> It seems that the spam attack continued well into last Saturday evening
> in the ticketing system. One last(?) attempt was made yesterday and=20
> then
> things went silent. Fortunately the mix of new spam filters seemed to
> block all the latest attempts properly. There was also one legitimate
> edit which got through without issues.
>=20
> Today I added Mollom filter to the mix to provide additional=20
> protection.
> I also started training the built-in Bayesian filter to make things=20
> even
> more difficult for spammers.
>=20
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc


This article sheds some light on what we're seeing - at least we're not=20
alone in the world. ;)

https://blog.malwarebytes.org/cybercrime/2015/04/tech-support-spam-plague-l=
inkedin-and-other-high-traffic-sites/

Eric Crist


