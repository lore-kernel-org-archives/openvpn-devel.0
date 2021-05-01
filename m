From: Antonio Quartulli <a@...2181...>
References: <20210422151724.2132573-1-arne@...1227...>
 <20210422151724.2132573-3-arne@...1227...>
 <634abd69-de3e-ba08-23e5-fbaa0c7b7fc3@...2181...>
Message-ID: <f4fbdace-93f9-d057-4d5f-9d6fd0293a8c@...2181...>
Date: Sat, 1 May 2021 15:27:26 +0200
MIME-Version: 1.0
In-Reply-To: <634abd69-de3e-ba08-23e5-fbaa0c7b7fc3@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/7] Return cached result in
 tls_authentication_status
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 30/04/2021 00:19, Antonio Quartulli wrote:
> Hi,
> 
> after applying this patch my deferred auth script test does not work
> anymore.
> 
> Regardless of deferred auth being succesful or not, the server never
> sends a push-reply or auth-failed to the client.
I take this back. Pure auth-user-pass (no deferred) works.

But as soon as we have deferred auth the server does not reply to the
client anymore.

I will comment on the patch with a possible explanation.

Regards,

-- 
Antonio Quartulli

