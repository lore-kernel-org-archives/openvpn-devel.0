MIME-Version: 1.0
References: <20230201041831.2259419-1-selva.nair@...277...>
In-Reply-To: <20230201041831.2259419-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 1 Feb 2023 11:36:48 +0200
Message-ID: <CAGyAFMVw=QzQDaBo6RE9Juh5+SObuCmAptT+yh1X44DL2g7bBQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] block-dns using iservice: fix a
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

I made a slightly different fix but then noticed your mail.

Indeed the problem is that get/set_interface_metric fails,
and we call FwpmEngineClose0 after updating the undo list. When
openvpn process exits, we execute commands in undo list,
and second call to FwpmEngineClose0 causes Access Violation
inside WFP.

Note that since get_interface_metric() fails, it sets interface_data->metric_v4
to -1. In this case we should not restore metrics back (which will
fail in any case).
We have a very similar code (including metrics value check) just below which
handles msg_del_block_dns. Can we factor it out into a separate function?

-- 
-Lev

