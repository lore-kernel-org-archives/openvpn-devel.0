Message-ID: <5166B459.9020801@...515...>
Date: Thu, 11 Apr 2013 16:02:17 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1346422753-19520-1-git-send-email-arne@...1227...>
	<201304110933.r3B9XwPT011987@...1729...>
	<20130411105202.GA26778@...1296...>
In-Reply-To: <20130411105202.GA26778@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add the client id (CID) to
 the output of the status command
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Thu, Apr 11, 2013 at 11:33:58AM +0200, Gert Doering wrote:
>> Your patch has been applied to the master branch (ACK by me).=20=20
>>
>> I'm not sure whether we need this in release/2.3, but if people see the=
=20
>> need, please speak up and I'll cherry-pick :-)
>>
>> commit 662ce6acc065bddf6490b3494725b8b3987b7def (master)
> ... unfortunately, it breaks --disable-managemnt builds :-( - good that
> we have buildbots, stupid me for not noticing it before ACK-and-push.
I wonder if using a "staging" repo would be too much trouble? Buildbots
could track it, and only after all builds have succeeded, the changes
would be pushed to master.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


