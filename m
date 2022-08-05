Message-ID: <d8beb891-bbdf-3bd1-4176-d2febbea6299@...1227...>
Date: Fri, 5 Aug 2022 10:27:27 +0200
MIME-Version: 1.0
References: <Yt2Fdvaom94pVcOQ@...2684...> <Yt2Wqc2zTdyx5Zj5@...1296...>
 <Yt2Zkt1K5ThfAaYn@...1296...>
 <CAHV-TD7uaLPC=FcQisWJDL4VWSQx=65r8mAsHJBZMYSk0K7+Cg@...278...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <CAHV-TD7uaLPC=FcQisWJDL4VWSQx=65r8mAsHJBZMYSk0K7+Cg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] PUSH_BUNDLE_SIZE is too short
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Angel Abad <angel@...334...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net


Am 05.08.2022 um 08:58 schrieb Angel Abad:
> Hi, sorry for my late reply!
>
> We use on server side managed AWS Clientvpn product[1], but we 
> havent the problem with macosX or windows laptops, only with linux 
> (ubuntu, centos and debian).
>
OpenVPN Connect which is based on OpenVPN 3.x might be more tolerant 
which accepting oversized PUSH replys. That however still does not make 
it a legal packet. You should complain to Amazon. This is a bug on their 
side that they have to fix.


Arne


