Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <20160605172402.GT53051@...1296...>
Date: Mon, 6 Jun 2016 00:45:34 +0200
Message-Id: <18582A10-D0B7-449F-96CA-7F778B99E0DC@...2127...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<20160605172402.GT53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
	framework
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>=20
>> IMO, the unit testing patches shouldn't have been merged into the release
>> branch
>=20
> I have discussed this with David (after the fact, meh) and we couldn't=20
> really come to an conclusion on this - but since you and Jens now both
> argue that way (and especially Jens as the original author should have
> some authority here :-) )  I think we'll revert the four relevant patches
> again.  Looks silly, but keeping stuff in a tree where we did not want
> it to go in the first place, and then spending time maintaining it there
> looks even more silly to me=E2=80=A6


I agree to remove them from the next stable, but honestly think we really
should go the last step and make them work in master.

Is anything besides mingw still an issue with the unit testing patchset?

Jens
