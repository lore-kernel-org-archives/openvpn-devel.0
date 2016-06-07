References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<5755C95E.9080401@...2080...>
	<CAKuzo_jivce2XsfJeJaY2n+NqRqUWSPkWejyHZMNuqHxGZUCcg@...278...>
	<5755DF70.8050406@...2080...>
	<20160607081413.GP53051@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a56ebdac-1f0d-d6e3-7249-231711c160dc@...515...>
Date: Tue, 7 Jun 2016 13:31:05 +0300
MIME-Version: 1.0
In-Reply-To: <20160607081413.GP53051@...1296...>
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
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

> Given that we do not have plenty of developer time around, we should focus
> *development* time on git master / 2.4 - and that includes adding testing
> frameworks.

+1. We should focus on doing what it takes to (finally) get 2.4 out of=20
the door. Fairly soon afterwards we can stop worrying about 2.3 and the=20
rather large incompatibilities between release/2.3 and master branch.

Post-2.4 we should start releasing major releases more often and with=20
fewer features, so that the stable branch is not _that_ old when the=20
next major release is made. That way the "release" and "master" branches=20
do not diverge too much, and there is less need for cherry-picking=20
patches and separately testing patching on the "release" branch. An=20
added benefit is that more people will be using more recent code.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

