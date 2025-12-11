Date: Thu, 11 Dec 2025 12:33:52 +0100 (CET)
Message-Id: <202512111133.5BBBXqT1059918@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251211105956.22789-1-gert@...1296...>
References: <20251211105956.22789-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Deprecate --fast-io option
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

So we had quite a bit of discussion on this - how much difference does it
make (~5%), is it worth it, ... - and the result of that was "it is not
working correctly due to multisocket patchset fallout" and "the event code
around UDP is way too complex and nobody understands it anymore".

So removing --fast-io simplifies quite a bit of the complicated event stuff
(and after 2.7.0 release we can have a new look on how to make this more
efficient in the light of "multiple sockets to deal with" - a GH issue
has already been opened on this so we won't forget).

I have stared long and hard at the changes, and run the full set of client
and server tests on "linux without DCO" and "linux with DCO".  Especially
the first set also has async scripts/plugins, inotify, and all that - and
everything still works.  So in it goes :-)

Your patch has been applied to the master branch.

commit e5ff824753a7ebeb1cf78f1f0d86f3790eff83e6
Author: Gianmarco De Gregori
Date:   Thu Dec 11 11:59:51 2025 +0100

     Deprecate --fast-io option

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1425
     Message-Id: <20251211105956.22789-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35024.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


