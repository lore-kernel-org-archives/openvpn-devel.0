Date: Wed, 30 Nov 2022 13:35:37 +0100 (CET)
Message-Id: <202211301235.2AUCZbbm012064@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221130105502.662374-1-selva.nair@...277...>
References: <20221130105502.662374-1-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: pull-filter: ignore leading
 spaces in option names
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Acked-by: Gert Doering <gert@...1296...>

I thought we might not need it, but Arne says it's useful, and it's
really trivial and not adding much code.  *line is a local variable,
so it can't have side effects, and isspace(*line) is "end of string"-safe
as well.

Tested, of course, to a server that still had the extra blank

$ openvpn --pull-filter ignore auth-token ...

without the patch:

2022-11-30 13:10:41 PUSH: Received control message: 'PUSH_REPLY, auth-tokenSESS_ID'
2022-11-30 13:11:37 PUSH: Received control message: 'PUSH_REPLY, auth-tokenSESS_ID'

with the patch:

2022-11-30 13:21:02 PUSH: Received control message: 'PUSH_REPLY, auth-tokenSESS_ID'
2022-11-30 13:21:02 Pushed option removed by filter: 'auth-token SESS_ID_...
2022-11-30 13:21:59 PUSH: Received control message: 'PUSH_REPLY, auth-tokenSESS_ID'
2022-11-30 13:21:59 Pushed option removed by filter: 'auth-token SESS_ID_...


Your patch has been applied to the master and release/2.5 branch.

commit f02946ff9900a37dd36f61748173d53eca01adf9 (master)
commit 00952a6184da0a77fbabe801d842a7546058f6c2 (release/2.5)
Author: Selva Nair
Date:   Wed Nov 30 05:55:02 2022 -0500

     pull-filter: ignore leading spaces in option names

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20221130105502.662374-1-selva.nair@...277...>
     URL: https://www.mail-archive.com/search?l=mid&q=20221130105502.662374-1-selva.nair@...277...
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


