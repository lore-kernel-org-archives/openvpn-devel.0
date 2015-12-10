From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 10 Dec 2015 11:55:16 +0200
Message-ID: <56694C04.6020904@...277...>
References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
Mime-Version: 1.0
In-Reply-To: <1449656275-24934-1-git-send-email-iam@...2070...>
Subject: Re: [Openvpn-devel] [PATCH v8-master] Add Windows DNS Leak fix
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
To: openvpn-devel@lists.sourceforge.net

Hi,

Sorry for the late response.

+bool
+win_wfp_uninit()
+{
+    dmsg (D_LOW, "Uninitializing WFP");
+    if (m_hEngineHandle) {
+        FwpmSubLayerDeleteByKey0(m_hEngineHandle, &m_subLayerGUID);
+        CLEAR(m_subLayerGUID);
+        FwpmEngineClose0(m_hEngineHandle);
+        m_hEngineHandle = NULL;


FwpmSubLayerDeleteByKey0 will likely fail if there is a filter 
associated with sublayer. On the other side, FwpmEngineClose0 seems to 
be enough to remove blocking.

I think the correct way would be to create GUID for filter same way as 
you did for sublayer and copy it to filter.filterKey. In uninit method, 
before deleting sublayer you call FwpmFilterDeleteByKey0 with that guid.

-Lev


