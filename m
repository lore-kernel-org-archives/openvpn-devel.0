References: <20200909122926.9523-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <986465b6-d9bc-f102-8ffd-f8b79dfc19a7@...2181...>
Date: Fri, 11 Sep 2020 14:35:06 +0200
MIME-Version: 1.0
In-Reply-To: <20200909122926.9523-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix description of --client-disconnect
 calling convention in manpage.
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

On 09/09/2020 14:29, Gert Doering wrote:
> The man page claimed that --client-disconnect "is passed the same
> pathname as the corresponding --client-connect command", which is
> not what the code does.  Fix.
> 
> Reported-By: hvenev in Trac
> Trac: #884
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Checked the code and I agree with Gert fix to the documentation.
No additional argument is passed.

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

