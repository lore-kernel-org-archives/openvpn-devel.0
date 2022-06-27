Message-ID: <04dc1744-eace-8ee8-a888-b20d459fe60b@...2080...>
Date: Mon, 27 Jun 2022 22:19:29 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220217182234.33850-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20220217182234.33850-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3] Fix OpenVPN querying user/password
 if auth-token with user expires
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>


On 17/02/2022 19:22, Arne Schwabe wrote:
> The problematic behaviour happens when start a profile without

That sentence can be improved slightly; can be done commit time.  I propose:

   The problematic behaviour happens when a profile is started without

> auth-user-pass and connect to a server that pushes auth-token
> When the auth token expires OpenVPN asks for auth User and password
> again.
> 
> The problem is that the auth_user_pass_setup sets
> auth_user_pass_enabled = true; This function is called from two places.
> In ssl.c it is only called with an auth-token present or that
> variable already set. The other one is init_query_passwords.
> 
> Move setting auth_user_pass_enabled to the second place to ensure it is
> only set if we really want passwords.
> 
> Patch v2: Remove unrelated code change
> Patch v3: Rebase to master
> 
> Signed-off-by: Arne Schwabe <arne@...1227...
I've done several attempts to reproduce the ill behavior with
OpenVPN 2.5.7, both local server (using the --management interface), 
OpenVPN Cloud and OpenVPN Access Server (auto-login profile) without 
being able to trigger this behavior.  Maybe my testing just didn't run 
long enough.  Connections was restarted, servers restarted to wipe 
state, etc.  But it just reconnected again without any issues.  So 
behavior this patch fixes is clearly in the "corner case" area of bugs.

That said, the code looks fine and sane.  I can understand the code path 
and I can see that username/passwords should - in theory - not be asked 
for when the auth-token expires with this fix; and that it would ask for 
it without this fix.

Acked-By: David Sommerseth <davids@...515...>

-- 
kind regards,

David Sommerseth
OpenVPN Inc


