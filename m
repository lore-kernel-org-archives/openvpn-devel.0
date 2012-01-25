Resent-Message-Id: <201201260736.q0Q7aR6c024369@...1295...>
MIME-Version: 1.0
In-Reply-To: <20120125221803.GE5060@...1296...>
References: <1327405130-22393-1-git-send-email-davids@...1347...>
	<CAEsd45R22XK71TEfe8rVCooQ65XsKDTCW_QB9p06VuQmQK0C3g@...278...>
	<20120125221803.GE5060@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 25 Jan 2012 17:49:51 -0500
Message-ID: <CAEsd45SK+fB=Cgkg2PBNeCyL29t20mi2CPWHymWZsh4Gr0--1w@...278...>
Resent-To: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH] Add
 --route-pre-down/OPENVPN_PLUGIN_ROUTE_PREDOWN script/plug-in hook
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

On Wed, Jan 25, 2012 at 5:18 PM, Gert Doering <gert@...1296...> wrote:
>> If so, shouldn't patches that
>> change the interface include appropriate changes to the man page?
>
> ... and so does the patch. =A0At least my copy of it had a section starti=
ng
> with

My apologies. I didn't connect that part of the patch with the man page.

However, it looks the patch only adds an entry for the _script_ to the
"Script Order of Execution" section.

The description of the _option_ that sets up the script to be
executed, the "--route-pre-down" option, that appears in the patch for
options.c only affects the usage message, not the man page. I think
that description (or something similar) should also be included in the
man page (i.e., in openvpn.8).

Also, it might help to clarify that the script is called before
anything at all is done about the disconnection (which I assume is
true). In other words, that the route teardown is the first step in
the disconnection process. But if that's covered elsewhere I apologize
(again!).

And maybe the copyright notice in openvpn.8 should be updated, too?

Sorry to be a pest if I am still off base.


