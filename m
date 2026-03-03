MIME-Version: 1.0
References: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
 <20260302205324.10025-1-gert@...1296...>
In-Reply-To: <20260302205324.10025-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 2 Mar 2026 19:09:15 -0500
Message-ID: <CAKuzo_hYOqJH8cw8YB-AOt_bBqD1bhL1UqG-AS0tFPBh0FRuOw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v6] Add an optional username-only flag
 for auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

> Internally, the password gets set as "[[BLANK]]" which is currently
> used as tag for blank password.

Unfortunately this works only when prompted from the command line. For
management
interface we need to enforce this after management_query_user_pass()
returns as it
overwrites the whole user_pass structure.

I can follow up with a fixup or submit a version after the management-version
documentation patch is merged as that may create a conflict anyway.

Selva

