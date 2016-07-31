References: <CAEsd45T1XbZNypuu-z-enngS0Pz7eXEX5qBwN7Wj7jU-s7hz1w@...278...>
	<d67f698a-e0e7-e86e-f62f-e651070c7d05@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <00f9684f-7e7d-c258-c468-008a9855421d@...2080...>
Date: Sun, 31 Jul 2016 13:22:33 +0200
MIME-Version: 1.0
In-Reply-To: <d67f698a-e0e7-e86e-f62f-e651070c7d05@...515...>
Subject: Re: [Openvpn-devel] The end of the Gmane archive
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, "Jonathan K. Bullard" <jkbullard@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 30/07/16 11:40, Samuli Sepp=E4nen wrote:
> Il 29/07/2016 21:13, Jonathan K. Bullard ha scritto:
>> Yesterday Lars Ingebrigtsen, who established and has run Gmane since
>> 2002, posted an article saying that Gmane might go away [1].
>>
>> He posted an update [2] which says the Gmane archive *has* gone away
>> and unless someone steps up to take it over, it is gone for good.
>>
>> The OpenVPN mailing list archives are still available on SourceForge,
>> but it might be worth thinking about adding openvpn-dev and
>> openvpn-users to The Mail Archive [3] or some other such service.
>>
>> [1] https://lars.ingebrigtsen.no/2016/07/28/the-end-of-gmane
>> [2] https://lars.ingebrigtsen.no/2016/07/28/the-end-of-gmane/comment-pag=
e-1/#comment-13502
>> [3] https://www.mail-archive.com
>>
>=20
> I looked at the mail-archive FAQ and that seemed promising. I'll take a=20
> closer look in a couple of weeks.
>=20
> Based on comments in the second link there's a real chance that nobody=20
> will reimplement a Web UI for Gmane for hosting the archive data, and=20
> that links to Gmane will be gone forever.

On LWN there are some more comments to these sad news.  I understand
Lars' motivation to step down, and I hope someone will manage to pick up
after Lars.  The reason is that gmane is mailing list archive I've found
which has a sane thread view (which also responded to keytboard events).

Jon Corbet says in a comment:

    I've been talking a bit with Lars; money doesn't seem to be the
    issue. He's really just ready to hand it off. I think we might have
    found a good prospective home for gmane, but it will take a little
    while to know for sure.

And I see that cloudflare has been put in front of gmane.org now (though
not yet working).  So these might be some traces of that.

Anyhow, this scenario is why we put Message-ID in our commit logs.  The
URL to gmane.org was primarily for convenience, the Message-ID field is
the mandatory field in our commit messages.  So unless gmane.org
re-appears or something better comes up, we will just update our git
scripts to use a different convenience URL.


--=20
kind regards,

David Sommerseth

