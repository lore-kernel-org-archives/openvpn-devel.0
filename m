References: <20210319153129.8734-1-arne@...1227...>
 <20210319153129.8734-2-arne@...1227...>
 <08c1d3c8-d5d1-f329-57a6-a2d07ec39430@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <513d1277-6e4e-5215-e0d4-ac2aa0d042b3@...1227...>
Date: Sun, 21 Mar 2021 13:56:32 +0100
MIME-Version: 1.0
In-Reply-To: <08c1d3c8-d5d1-f329-57a6-a2d07ec39430@...2080...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 2/2] Implement '--compress migrate' to
 migrate to non-compression setup
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
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Am 20.03.21 um 14:20 schrieb David Sommerseth:
> On 19/03/2021 16:31, Arne Schwabe wrote:
>> This option allow migration to a non compression server config while
>> still retraining compatibility with client that have a compression
>> setting in their config.
>>
>> For existing setups that used to have comp-lzo no or another
>> compression setting in their configs it is a difficult to migrate to
>> a setup without compression without replacing all client configs at
>> once especially if OpenVPN 2.3 or earlier clients are in the mix that
>> do not support pushing stub-v2. Even with OpenVPN 2.4 and later clients
>> that support pushing this is not a satisfying solution as the clients
>> log occ mismatches and the "push stub-v2" needs to be in the server
>> config "forever".
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>   doc/man-sections/protocol-options.rst | 12 +++-
>>   src/openvpn/comp.h                    |  1 +
>>   src/openvpn/multi.c                   | 41 +++++++++++++
>>   src/openvpn/options.c                 |  6 ++
>>   src/openvpn/ssl.c                     | 34 ++++++++++-
>>   src/openvpn/ssl_common.h              |  1 +
>>   src/openvpn/ssl_util.c                | 43 ++++++++++++++
>>   src/openvpn/ssl_util.h                | 15 +++++
>>   tests/unit_tests/openvpn/Makefile.am  | 14 ++++-
>>   tests/unit_tests/openvpn/test_misc.c  | 83 +++++++++++++++++++++++++++
>>   10 files changed, 245 insertions(+), 5 deletions(-)
>>   create mode 100644 tests/unit_tests/openvpn/test_misc.c
>>
> 
> This fails compiling:
> 
> ../../../src/openvpn/ssl.c: In function ‘key_method_2_write’:
> ../../../src/openvpn/ssl.c:2280:13: error: ‘multi’ undeclared (first use
> in this function)
>          if (multi->remote_usescomp && session->opt->mode == MODE_SERVER
>              ^~~~~
> ../../../src/openvpn/ssl.c:2280:13: note: each undeclared identifier is
> reported only once for each function it appears in
> make[3]: *** [Makefile:742: ssl.o] Error 1

Oh the fun of rebasing. The multi argument was added by another patch.
Can you just the small patch to review the rest of the patch?:

 static bool
-key_method_2_write(struct buffer *buf, struct tls_session *session)
+key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct
tls_session *session)
 {
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary
key */

@@ -2856,7 +2856,7 @@ tls_process(struct tls_multi *multi,
         if (!buf->len && ((ks->state == S_START && !session->opt->server)
                           || (ks->state == S_GOT_KEY &&
session->opt->server)))
         {
-            if (!key_method_2_write(buf, session))
+            if (!key_method_2_write(buf, multi, session))
             {
                 goto error;
             }

