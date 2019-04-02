References: <20190329122724.24169-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1389fa62-1924-5139-d128-4e9122ae382a@...2080...>
Date: Tue, 2 Apr 2019 12:45:37 +0300
MIME-Version: 1.0
In-Reply-To: <20190329122724.24169-1-arne@...1227...>
Content-Language: en-GB
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 29/03/2019 14:27, Arne Schwabe wrote:
> With modern Clients and server initialising the crypto cipher later
> and not when reading in the config, most users never the warning when
> having selected BF-CBC in the configuration.
> 
> This patch adds the logic to print out warning to init_key_type.
> 
> Main reason for this patch is a personal experience with someone who was
> strictly against putting 'cipher' into a config file because he did not
> like hardcoding a cipher and "OpenVPN will do AES-GCM anyway" and thinks
> that it is better to not have it in configuration even after told by me
> that 15 year defaults might not be good anymore.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
Just so that I understand this correctly.

If a pre-2.4 _server_ (or 2.4 server with NCP disabled) uses default BF-CBC
and the client is *not* listing --cipher at all - expecting the server to push
a sane cipher - the current behaviour will to NOT warn about a weak cipher.
Is that correctly understood?

In general, I don't mind annoying/scaring users that they use an insecure
cipher - no matter if it is through direct or indirect (pushed) configuration
options.

-- 
kind regards,

David Sommerseth
OpenVPN Inc


