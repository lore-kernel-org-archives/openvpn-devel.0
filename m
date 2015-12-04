References: <565A3985.3030800@...1227...>
	<1448835033-24287-1-git-send-email-iam@...2070...>
	<CAKuzo_iVJWYj9v3UtdYscBG1BvfwYj33TMrr0b48tk5n_yXxCQ@...278...>
From: James Yonan <james@...515...>
Message-ID: <5660EA2A.1020903@...515...>
Date: Thu, 3 Dec 2015 18:19:38 -0700
MIME-Version: 1.0
In-Reply-To: <CAKuzo_iVJWYj9v3UtdYscBG1BvfwYj33TMrr0b48tk5n_yXxCQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v7-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel@lists.sourceforge.net

These may have been fixed by now, but noticed some issues in the 
original patch that was discussed in the OpenVPN-devel IRC meeting 
several weeks ago.

* win_adapter_index_to_luid is declared to return a
   NET_LUID but not all code paths return a value.

* wcscat(svchostpath, L"\\svchost.exe") isn't checking
   for buffer overflow.

* FwpmGetAppIdFromFileName0 must be paired with a
   corresponding FwpmFreeMemory0

James

