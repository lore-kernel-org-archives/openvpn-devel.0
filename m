References: <20210722162409.231265-1-arne@...1227...>
 <YPpkRcqhj/QAjfyi@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b131dec2-5736-0ef0-5bb4-c65d461ff405@...1227...>
Date: Fri, 23 Jul 2021 11:37:37 +0200
MIME-Version: 1.0
In-Reply-To: <YPpkRcqhj/QAjfyi@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix OpenVPN querying user/password if
 auth-token with user expires
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 23.07.21 um 08:40 schrieb Gert Doering:
> Hi,
> 
> On Thu, Jul 22, 2021 at 06:24:09PM +0200, Arne Schwabe wrote:
>> @@ -3116,6 +3117,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
>>      to.auth_token_generate = options->auth_token_generate;
>>      to.auth_token_lifetime = options->auth_token_lifetime;
>>      to.auth_token_call_auth = options->auth_token_call_auth;
>> +    to.auth_token_user_common_name = options->auth_token_user_common_name;
>>      to.auth_token_key = c->c1.ks.auth_token_key;
>>  
>>      to.x509_track = options->x509_track;
> 
> That hunk looks unrelated...?
> 
> gert
> 
Oops :/

Is there anything wrong or should I send a v2 just with that change?

Arne

