Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180404121357.2126-1-davids@...515...>
 <CAKuzo_iYEY59K_SR4QRP3-X4bayF0BaCZdAxit6RQBmaDCsp0A@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a0ac1495-d40f-94f0-8770-bc4ed7669df7@...2080...>
Date: Wed, 4 Apr 2018 17:07:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iYEY59K_SR4QRP3-X4bayF0BaCZdAxit6RQBmaDCsp0A@...278...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] man: Improve token based authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 04/04/18 16:24, Selva Nair wrote:
> Hi,
> 
> On Wed, Apr 4, 2018 at 8:13 AM, David Sommerseth <davids@...515...> wrote:
>> Be more explicit that --auth-gen-token is to be considered a workaround
>> for authentication scripts/plug-ins not supporting --auth-token.
>>
>> Also be more explicit that invalidated --auth-token values will result
>> in the client disconnecting.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
> 
> IMO, this is just muddying up waters further. To the user its still not
> clear when does the token get invalidated and in which of those cases
> is the client left in a lurch. The token gets invalidated on (i) token
> expiry (a broken feature) or (ii) server restart. The client can
> recover from the latter as it will get an auth-failed, but the former
> causes a disconnection from server's perspective but client gets no
> notice. So saying that "will result in the client disconnecting" is
> not helpful.
> 
> A better quick fix would be to just remove token expiry feature from
> the code until a proper implementation can be devised.

The intention to this patch is actually not directly tied to the fixes needed
to the --auth-gen-token handling at all.  This is just to clarify the current
behaviour.

In addition, it became clearer to me that the --auth-gen-token might be
perceived as a "one-stop-fix" for authentication plug-ins/scripts not
supporting auth-tokens.

Further, the token expiry is an opt-in feature.  It is something the
authentication script/plug-in need to handle, or explicitly enabled with
--auth-gen-token by providing an expiry timeout.

Arne and I have discussed his patch today, and agreed upon a path forward of
fixing these issues as well and ensure that both OpenVPN 2 in client mode and
OpenVPN 3 based clients all behave in a similar way.  This does also not rule
out that we might need to fix OpenVPN 3 as well.  But consistent behaviour
across versions with a reasonably good user experience is the core goal.  We
just need to take this carefully, step by step.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


