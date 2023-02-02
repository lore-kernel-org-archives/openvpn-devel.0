MIME-Version: 1.0
References: <20230201041831.2259419-1-selva.nair@...277...>
 <20230201170735.2266851-1-selva.nair@...277...>
In-Reply-To: <20230201170735.2266851-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 2 Feb 2023 09:52:41 +0200
Message-ID: <CAGyAFMVUUCL7rKn8dJi7kC1jYjtpKdyxjzvDKDTzJBXatXG6LA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] block-dns using iservice: fix a
 potential double free
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Stared at the code and tested with/without Citrix DME (which caused
crash) - code is now cleaner
(add/delete separation) and no crash anymore. Next we will fix the driver :)

Acked-by: Lev Stipakov <lstipakov@...277...>

