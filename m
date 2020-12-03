References: <53a9d994-312d-4349-33d2-2a0d39f50882@...2181...>
 <20201203182230.33552-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <0fa6a0a8-030e-8761-dd65-8d88b958a8e2@...2181...>
Date: Thu, 3 Dec 2020 19:56:42 +0100
MIME-Version: 1.0
In-Reply-To: <20201203182230.33552-1-steffan@...1856...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2 v2] tls-crypt-v2: fix server memory
 leak
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Hi,

On 03/12/2020 19:22, Steffan Karger wrote:
> tls-crypt-v2 was developed in parallel with the changes that allowed to
> use tls-auth/tls-crypt in connection blocks. The tls-crypt-v2 patch set
> was never updated to the new reality after commit 5817b49b, causing a
> memory leak of about 600 bytes for each connecting client.
> 
> It would be nicer to not reload the tls-crypt-v2 server key for each
> connecting client, but that requires more refactoring (and thus more time
> to get right). So for now just plug the leak by free'ing the memory when
> we close a client connection.
> 
> To test this easily, compile openvpn with -fsanity=address, run a server
> with tls-crypt-v2, connect a client, stop the server.
> 
> Signed-off-by: Steffan Karger <steffan@...1856...>


Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

