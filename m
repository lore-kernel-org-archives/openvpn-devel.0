References: <20200909130024.24264-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <268c3675-20be-5fc2-4ec2-f79b34ae1c0e@...2181...>
Date: Fri, 11 Sep 2020 12:37:48 +0200
MIME-Version: 1.0
In-Reply-To: <20200909130024.24264-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Replace 'echo -n' with 'printf' in
 tests/t_lpback.sh
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 09/09/2020 15:00, Gert Doering wrote:
> "echo -n" is inherently less portable than printf, so the tests look
> ugly on (at least) OpenSolaris/Illumos on AIX.
> 
> Add a blank at the end of the tls-crypt-v2 messages, so it has the
> same look as the cipher messages ("... OK").
> 
> Reported-by: mnowak on Trac
> Trac: #1196
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Change is not invasive and makes sense.

Gert is juggling way more platforms than I do, so if he believes this
helps portability, I am with him.

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

