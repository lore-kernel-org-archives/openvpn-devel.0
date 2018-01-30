MIME-Version: 1.0
In-Reply-To: <6a3cabee-e9ea-bea6-cca7-d3f9672f292f@...515...>
References: <6a3cabee-e9ea-bea6-cca7-d3f9672f292f@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 30 Jan 2018 12:21:58 -0500
Message-ID: <CAKuzo_jTyA42EJtwcr5xsRRVbMy5WzPibbZHSPEa9piBJ14ozg@...278...>
Subject: Re: [Openvpn-devel] Topics for the community meeting (Wed,
 31st Jan 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

A quick comment regarding item 2 in topics:
> 2 mgmt version 2 / pk-sign and 2.4
>  Is this something we want in 2.4? If not, how's the GUI going to deal wi=
th 2.4 and master being different?"

Unless 2.4 is getting EC cert external signing support, we do not need
this in there, do we?

I think it shouldn't be a problem for UI's as the master will behave
the same way as 2.4 towards old UI's. New/updated UI's are expected to
first check the management version of the daemon, then optionally
announce version 2 support, and be prepared to handle old and
new-style requests.

Anyway, "The Windows GUI" doesn't care as it does not handle signature
requests. Jonathan said the same about Tunneblick.

Selva

On Tue, Jan 30, 2018 at 7:09 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:
> Hi,
>
> We're going to have an IRC meeting starting at 11:30 CET
> (10:30 UTC) on #openvpn-meeting <at> irc.freenode.net. You do not have
> to be logged in to Freenode to join the channel.
>
> Current topic list along with basic information is here:
>
> <https://community.openvpn.net/openvpn/wiki/Topics-2018-01-31>
>
> If you have any other things you'd like to bring up, respond to this
> mail, send me mail privately or add them to the list yourself.
>
> In case you can't attend the meeting, please feel free to make comments
> on the topics by responding to this email or to the summary email sent
> after the meeting. Whenever possible, we'll also respond to existing,
> related email threads.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

