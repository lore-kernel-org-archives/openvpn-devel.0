References: <20190329122724.24169-1-arne@...1227...>
 <1389fa62-1924-5139-d128-4e9122ae382a@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <563e44b7-9782-2458-eebe-8ca65d94d90e@...1227...>
Date: Tue, 2 Apr 2019 12:54:57 +0300
MIME-Version: 1.0
In-Reply-To: <1389fa62-1924-5139-d128-4e9122ae382a@...2080...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Warn about insecure ciphers also in
 init_key_type
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
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

Am 02.04.19 um 11:45 schrieb David Sommerseth:
> On 29/03/2019 14:27, Arne Schwabe wrote:
>> With modern Clients and server initialising the crypto cipher later
>> and not when reading in the config, most users never the warning when
>> having selected BF-CBC in the configuration.
>>
>> This patch adds the logic to print out warning to init_key_type.
>>
>> Main reason for this patch is a personal experience with someone who was
>> strictly against putting 'cipher' into a config file because he did not
>> like hardcoding a cipher and "OpenVPN will do AES-GCM anyway" and thinks
>> that it is better to not have it in configuration even after told by me
>> that 15 year defaults might not be good anymore.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
> Just so that I understand this correctly.
> 
> If a pre-2.4 _server_ (or 2.4 server with NCP disabled) uses default BF-CBC
> and the client is *not* listing --cipher at all - expecting the server to push
> a sane cipher - the current behaviour will to NOT warn about a weak cipher.
> Is that correctly understood?

Condition is 2.4 server or 2.4 client with cipher BF-CBC in the config
(or no cipher). If they push/get a secure cipher pushed, never warn
about having an insecure configuration.

Especially on a server this is important because without cipher in both
client and server everything works but only you actually connect a 2.3
or ncp-disable, you get a warning that your configuration is potentially
insecure. With this patch, server/client warn as soon as you load the
configuration.

Arne

