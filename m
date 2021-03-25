References: <20210310154754.GH976@...1296...>
 <20210317130312.8585-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ca6c5842-df1c-86fa-0d82-f30912b0dc40@...2181...>
Date: Thu, 25 Mar 2021 23:57:12 +0100
MIME-Version: 1.0
In-Reply-To: <20210317130312.8585-1-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 1/2] Move auth deferred related
 members into its own struct
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

On 17/03/2021 14:03, Arne Schwabe wrote:
> This structures the code a bit nicer and also prepares for deferred
> scripts that needs their own set of files.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>

For me this is an ACK, but unfortunately I have no test rig for deferred
auth and therefore I cannot really test these code paths.

This said, after staring at the code, I can confirm this is just a
restyling of some struct members and nothing else.

A basic client-server test passes as expected.

Regards,

-- 
Antonio Quartulli

