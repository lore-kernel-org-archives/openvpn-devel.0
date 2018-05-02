References: <12f1f4f7-0b03-3f45-c06b-aec77e4e1ef1@...2181...>
 <20180308202303.6492-1-steffan@...1856...>
 <596506ef-7229-8d5c-f772-bc94473fe408@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <07bb3a3f-673d-2312-5c4e-6993aa0f6126@...1856...>
Date: Wed, 2 May 2018 19:51:48 +0200
MIME-Version: 1.0
In-Reply-To: <596506ef-7229-8d5c-f772-bc94473fe408@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v2] tls-crypt-v2: add specification to
 doc/
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Antonio,

Sorry for taking so long to respond - life was getting in the way.

On 16-04-18 15:03, Antonio Quartulli wrote:
> there was a comment in my previous review that remained unanswer.
> Please, see it below
> 
> On 09/03/18 04:23, Steffan Karger wrote:
> [CUT]
>> +   The metadata is checked *after* the OpenVPN three-way handshake has
>> +   completed, to prevent DoS attacks.  (That is, once the client has proved to
>> +   the server that it possesses Kc, by authenticating a packet that contains the
>> +   session ID picked by the server.)
> 
> 
> just a thought here: the metadata is actually created by the
> server/provider and it is authenticated/encrypted with the server key.
> 
> Isn't this enough to ensure that its content is not malicious and thus
> allow the server to parse it right after having received the
> HARD_RESET_V3 (instead of performing a "three-way handshake" first)?

Not really, because a mitm attacker can simply record the cookie, and
replay it.  By postponing our parsing, we reduce the impact of a DoS by
an attacker that is setting up many new connections with the cookie
attached.  Instead of performing a potential expensive check (running a
script) for each HARD_RESET_V3, all we do is unwrap and reply.  In more
formal terms, we require a proof-of-possession of Kc before we will do
any (potential) expensive operations.

-Steffan

