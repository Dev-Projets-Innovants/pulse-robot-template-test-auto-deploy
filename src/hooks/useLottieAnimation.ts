
import { useState, useEffect } from 'react';

interface UseLottieAnimationResult {
  animationData: any;
  loading: boolean;
  error: string | null;
  retry: () => void;
}

export const useLottieAnimation = (animationPath: string): UseLottieAnimationResult => {
  const [animationData, setAnimationData] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const loadAnimation = async () => {
    try {
      setLoading(true);
      setError(null);
      
      const response = await fetch(animationPath);
      
      if (!response.ok) {
        throw new Error(`Failed to load animation: ${response.status}`);
      }

      // Check if the response is JSON
      const contentType = response.headers.get('content-type');
      if (contentType && contentType.includes('application/json')) {
        const data = await response.json();
        setAnimationData(data);
      } else {
        // If it's not JSON, it might be a .lottie file (ZIP format)
        // For now, we'll show an error and use fallback
        throw new Error('Animation file format not supported. Expected JSON format.');
      }
    } catch (err) {
      console.error('Error loading Lottie animation:', err);
      setError(err instanceof Error ? err.message : 'Failed to load animation');
    } finally {
      setLoading(false);
    }
  };

  const retry = () => {
    loadAnimation();
  };

  useEffect(() => {
    loadAnimation();
  }, [animationPath]);

  return { animationData, loading, error, retry };
};
