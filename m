MIME-Version: 1.0
In-Reply-To: <20180404121357.2126-1-davids@...515...>
References: <20180404121357.2126-1-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 4 Apr 2018 10:24:28 -0400
Message-ID: <CAKuzo_iYEY59K_SR4QRP3-X4bayF0BaCZdAxit6RQBmaDCsp0A@...278...>
Subject: Re: [Openvpn-devel] [PATCH] man: Improve token based authentication
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
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Apr 4, 2018 at 8:13 AM, David Sommerseth <davids@...515...> wrote:
> Be more explicit that --auth-gen-token is to be considered a workaround
> for authentication scripts/plug-ins not supporting --auth-token.
>
> Also be more explicit that invalidated --auth-token values will result
> in the client disconnecting.
>
> Signed-off-by: David Sommerseth <davids@...515...>

IMO, this is just muddying up waters further. To the user its still not
clear when does the token get invalidated and in which of those cases
is the client left in a lurch. The token gets invalidated on (i) token
expiry (a broken feature) or (ii) server restart. The client can
recover from the latter as it will get an auth-failed, but the former
causes a disconnection from server's perspective but client gets no
notice. So saying that "will result in the client disconnecting" is
not helpful.

A better quick fix would be to just remove token expiry feature from
the code until a proper implementation can be devised.

Selva

