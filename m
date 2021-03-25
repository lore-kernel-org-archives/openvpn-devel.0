References: <20201215164221.5995-1-arne@...1227...>
 <20201215164221.5995-2-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <d9fa3e30-32a3-5b81-baeb-716e60fda38c@...2181...>
Date: Thu, 25 Mar 2021 23:37:36 +0100
MIME-Version: 1.0
In-Reply-To: <20201215164221.5995-2-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix condition to generate session
 keys
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

On 15/12/2020 17:42, Arne Schwabe wrote:
> For --nobind clients OpenVPN reuses the context and tls_multi structs
> of the previous clients and does not rerun the connect scripts on
> connect. But since it is a new client connection, the key_id is 0 and
> we postpone the key generation but it will never happen.

Can you explain how the --nobind on the client is related to the server
behaviour?

Are you saying that a client connecting from the same IP of another
client will share its session and tls_multi object?



-- 
Antonio Quartulli

