References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<1467502488-31549-1-git-send-email-selva.nair@...277...>
	<11772d2a-4877-0ed0-2484-7ef66e059737@...1227...>
	<CAKuzo_jjiW9hyVc_+Wo=2aBtAgUmmyOTuLmqCbsq7yq7PCdmGQ@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f94abd87-0113-19c7-12de-745ed1de8e42@...1227...>
Date: Mon, 4 Jul 2016 18:02:03 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jjiW9hyVc_+Wo=2aBtAgUmmyOTuLmqCbsq7yq7PCdmGQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Exponentially back off on repeated
 connect retries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>



Am 04.07.16 um 17:43 schrieb Selva Nair:
>
> Something like this is needed to protect against overflow of the 32
> bit int (signed int in this case). Think of the user specifying sec =
> 2^17. Any shift by more than 14 will  make sec = 0. A more
> sophisticated logic that counts the bits in sec before shifting is
> possible, but this looked simple.. Now that a v3 is needed, will
> change to an explicit check on overflow.
That do that check in options.c and complain there. :)

Arne

