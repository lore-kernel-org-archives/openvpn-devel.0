References: <20210422151724.2132573-1-arne@...1227...>
 <20210422151724.2132573-3-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <634abd69-de3e-ba08-23e5-fbaa0c7b7fc3@...2181...>
Date: Fri, 30 Apr 2021 00:19:35 +0200
MIME-Version: 1.0
In-Reply-To: <20210422151724.2132573-3-arne@...1227...>
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

after applying this patch my deferred auth script test does not work
anymore.

Regardless of deferred auth being succesful or not, the server never
sends a push-reply or auth-failed to the client.

I tested also non-deferred auth and it seems to have the same broken
behaviour.

Haven't checked yet what might be causing this.

Reverting this patch fixes the issue.

Regards,




-- 
Antonio Quartulli

