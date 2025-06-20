
-- Create products table
CREATE TABLE public.products (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL DEFAULT 0,
  category TEXT,
  image_url TEXT,
  stock_quantity INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

-- Add Row Level Security (RLS) - making products publicly readable for now
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

-- Allow everyone to read products (common for e-commerce sites)
CREATE POLICY "Products are publicly readable" 
  ON public.products 
  FOR SELECT 
  TO public
  USING (true);

-- Only authenticated users can insert products (you can adjust this based on your needs)
CREATE POLICY "Authenticated users can create products" 
  ON public.products 
  FOR INSERT 
  TO authenticated
  WITH CHECK (true);

-- Only authenticated users can update products
CREATE POLICY "Authenticated users can update products" 
  ON public.products 
  FOR UPDATE 
  TO authenticated
  USING (true);

-- Only authenticated users can delete products
CREATE POLICY "Authenticated users can delete products" 
  ON public.products 
  FOR DELETE 
  TO authenticated
  USING (true);
