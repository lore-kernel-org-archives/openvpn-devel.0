References: <1540991236-4016-1-git-send-email-steffan.karger@...1435...>
From: tincanteksup <tincanteksup@...277...>
Message-ID: <fab9ef7f-7f4e-0904-13d2-d91ec963e006@...277...>
Date: Wed, 31 Oct 2018 13:50:23 +0000
MIME-Version: 1.0
In-Reply-To: <1540991236-4016-1-git-send-email-steffan.karger@...1435...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt-v2: fix client reconnect bug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Tested this with Ubuntu client, patched applied &
Arch server, current master and it worked correctly.

Client did not crash when trying to "reconnect" to a server
when the server had been changed from TLS Crypt V2 to V1.

When the server was changed back to V2 the client connected
successfully.  The client ran the same instance throughout.

(Would test on Windows but can't since my old rig died)

Tested-by: Richard Bonhomme <tincanteksup@...277...>

